<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\NewsArticle;
use App\Models\Sport;
use App\Models\Team;
use App\Http\Resources\NewsArticleResource;
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
                    ->from('article_likes')
                    ->whereColumn('article_id', 'news_articles.id')
                    ->where('user_id', $user->id);
            }
        ]);

        $posts = $query->latest()->paginate(10);

        return NewsArticleResource::collection($posts);
    }

    /**
     * Get posts for the current admin only.
     */
    public function myPosts(Request $request)
    {
        $user = $request->user();

        // Only admins can access this endpoint
        if (!$user->isAdmin()) {
            return response()->json(['message' => 'Unauthorized. Admins only.'], 403);
        }

        $query = NewsArticle::with(['author', 'sport', 'team'])
            ->withCount('likes')
            ->where('author_id', $user->id);

        // Check if current user liked the post
        $query->addSelect([
            'is_liked' => function ($query) use ($user) {
                $query->selectRaw('count(*)')
                    ->from('article_likes')
                    ->whereColumn('article_id', 'news_articles.id')
                    ->where('user_id', $user->id);
            }
        ]);

        $posts = $query->latest()->paginate(10);

        return NewsArticleResource::collection($posts);
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
            'description' => 'sometimes|string',
            'content' => 'required|string',
            'sport_id' => 'sometimes|exists:sports,id',
            'team_id' => 'nullable|exists:teams,id', // Optional: link to specific team
            'image' => 'nullable|image|max:2048', // Max 2MB
            'category' => 'sometimes|string',
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
            'description' => $request->description ?? $request->content,
            'content' => $request->content,
            'image_url' => $path,
            'category' => $request->category ?? 'General',
            'sport_id' => $request->sport_id ?? 1,
            'team_id' => $request->team_id,
            'author_id' => $user->id,
            'published_at' => now(),
        ]);

        return new NewsArticleResource($article);
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

        return NewsArticleResource::collection($posts);
    }

    /**
     * Toggle like on a news article.
     */
    public function toggleLike($articleId, Request $request)
    {
        $user = $request->user();
        $article = NewsArticle::findOrFail($articleId);

        $existingLike = $article->likes()->where('user_id', $user->id)->first();

        if ($existingLike) {
            // Remove like
            $existingLike->delete();
            $liked = false;
            $message = 'Like removed';
        } else {
            // Add like
            $article->likes()->create(['user_id' => $user->id]);
            $liked = true;
            $message = 'Article liked';
        }

        return response()->json([
            'message' => $message,
            'liked' => $liked,
            'likes_count' => $article->likes()->count()
        ]);
    }

    /**
     * Update a news article.
     */
    public function update(Request $request, $id)
    {
        $user = $request->user();
        $article = NewsArticle::findOrFail($id);

        // Check if user is Admin or Super Admin
        if (!$user->isAdmin()) {
            return response()->json(['message' => 'Unauthorized. Admins only.'], 403);
        }

        // Admin Logic: Verify assigned sport
        if (!$user->isSuperAdmin() && $user->assigned_sport_id != $article->sport_id) {
            return response()->json(['message' => 'You can only edit news for your assigned sport.'], 403);
        }

        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'description' => 'sometimes|string',
            'content' => 'required|string',
            'sport_id' => 'sometimes|exists:sports,id',
            'team_id' => 'nullable|exists:teams,id',
            'category' => 'sometimes|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $article->update([
            'title' => $request->title,
            'description' => $request->description ?? $request->content,
            'content' => $request->content,
            'category' => $request->category ?? 'General',
            'sport_id' => $request->sport_id ?? $article->sport_id,
            'team_id' => $request->team_id ?? $article->team_id,
        ]);

        return new NewsArticleResource($article);
    }

    /**
     * Delete a news article.
     */
    public function destroy(Request $request, $id)
    {
        $user = $request->user();
        $article = NewsArticle::findOrFail($id);

        // Check if user is Admin or Super Admin
        if (!$user->isAdmin()) {
            return response()->json(['message' => 'Unauthorized. Admins only.'], 403);
        }

        // Admin Logic: Verify assigned sport
        if (!$user->isSuperAdmin() && $user->assigned_sport_id != $article->sport_id) {
            return response()->json(['message' => 'You can only delete news for your assigned sport.'], 403);
        }

        $article->delete();

        return response()->json([
            'message' => 'News article deleted successfully'
        ]);
    }
}
