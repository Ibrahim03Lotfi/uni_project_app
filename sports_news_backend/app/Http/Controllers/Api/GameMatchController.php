<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\GameMatchResource;
use App\Models\GameMatch;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class GameMatchController extends Controller
{
    /**
     * Store a newly created match.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'home_team_id' => 'required|exists:teams,id',
            'away_team_id' => 'required|exists:teams,id',
            'league_id' => 'required|exists:leagues,id',
            'sport_id' => 'required|exists:sports,id',
            'match_time' => 'required|date',
            'status' => 'required|in:scheduled,live,finished',
            'home_score' => 'nullable|integer',
            'away_score' => 'nullable|integer',
            'live_minute' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $match = GameMatch::create($request->all());

        return new GameMatchResource($match->load(['homeTeam', 'awayTeam', 'league', 'sport']));
    }

    /**
     * Display a listing of matches.
     */
    public function index()
    {
        $matches = GameMatch::with(['homeTeam', 'awayTeam', 'league', 'sport'])
            ->orderBy('match_time', 'desc')
            ->get();

        return GameMatchResource::collection($matches);
    }

    /**
     * Update a match.
     */
    public function update(Request $request, GameMatch $match)
    {
        $validator = Validator::make($request->all(), [
            'home_team_id' => 'sometimes|exists:teams,id',
            'away_team_id' => 'sometimes|exists:teams,id',
            'league_id' => 'sometimes|exists:leagues,id',
            'sport_id' => 'sometimes|exists:sports,id',
            'match_time' => 'sometimes|date',
            'status' => 'sometimes|in:scheduled,live,finished',
            'home_score' => 'nullable|integer',
            'away_score' => 'nullable|integer',
            'live_minute' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $match->update($request->all());

        return new GameMatchResource($match->refresh()->load(['homeTeam', 'awayTeam', 'league', 'sport']));
    }

    /**
     * Delete a match.
     */
    public function destroy(GameMatch $match)
    {
        $match->delete();

        return response()->json(['message' => 'Match deleted successfully']);
    }
}
