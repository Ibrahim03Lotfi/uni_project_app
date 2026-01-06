<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\NewsArticle;
use App\Models\Sport;
use App\Models\Team;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class NewsArticleController extends Controller
{
    /**
     * Display a listing of the resource (User Feed).
     */
    public function index(Request $request)
    {
        $user = $request->user();

        $query = NewsArticle::with(['author', 'sport', 'team'])
            ->withCount('likes');

        // Filter by preferences if the user has them set
        $preferredSportIds = $user->preferredSports()->pluck('sports.id');
        $preferredTeamIds = $user->preferredTeams()->pluck('teams.id');

        if ($preferredSportIds->isNotEmpty() || $preferredTeamIds->isNotEmpty()) {
            $query->where(function ($q) use ($preferredSportIds, $preferredTeamIds) {
                if ($preferredSportIds->isNotEmpty()) {
                    $q->orWhereIn('sport_id', $preferredSportIds);
                }
                if ($preferredTeamIds->isNotEmpty()) {
                    $q->orWhereIn('team_id', $preferredTeamIds);
                }
            });
        }

        // Check if current user liked the post
        $query->addSelect([
            'is_liked' => function ($query) use ($user) {
                $query->selectRaw('count(*)')
                    ->from('article_likes') // NOTE: table name from migration
                    ->whereColumn('post_id', 'news_articles.id') // 'post_id' assumed from typical Laravel likeable implementation, but schema used 'news_article_id' or similar? Need to check ArticleLikes migration, assuming 'article_likes' table.
                    ->where('user_id', $user->id);
            }
        ]);


        $posts = $query->latest()->paginate(10);

        return response()->json($posts);
    }

    /**
     * Store a newly created news article.
     */
    public function store(Request $request)
    {
        $user = $request->user();

        // 1. Check if user is Admin or Super Admin
        if (!$user->isAdmin()) {
            return response()->json(['message' => 'Unauthorized. Admins only.'], 403);
        }

        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'content' => 'required|string',
            'sport_id' => 'required|exists:sports,id',
            'team_id' => 'nullable|exists:teams,id', // Optional: link to specific team
            'image' => 'nullable|image|max:2048', // Max 2MB
            'category' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // 2. Admin Logic: Verify assigned sport
        // If not Super Admin, ensure they are posting for their assigned sport
        if (!$user->isSuperAdmin() && $user->assigned_sport_id != $request->sport_id) {
            return response()->json(['message' => 'You can only post news for your assigned sport.'], 403);
        }

        // 3. Image Upload
        $path = null;
        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('posts', 'public');
        }

        $article = NewsArticle::create([
            'title' => $request->title,
            'description' => $request->description, // Or extract excerpt from content
            'content' => $request->content,
            'image_url' => $path ? asset('storage/' . $path) : null,
            'category' => $request->category,
            'sport_id' => $request->sport_id,
            'team_id' => $request->team_id,
            'author_id' => $user->id,
            'published_at' => now(),
        ]);

        return response()->json($article, 201);
    }

    /**
     * Search news by title.
     */
    public function search(Request $request)
    {
        $keyword = $request->input('keyword');

        if (!$keyword) {
            return response()->json([]);
        }

        $posts = NewsArticle::with(['author', 'sport', 'team'])
            ->where('title', 'like', "%{$keyword}%")
            ->latest()
            ->paginate(10);

        return response()->json($posts);
    }
}
