<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\League;
use App\Models\Team;
use App\Http\Resources\TeamResource;
use Illuminate\Http\JsonResponse;

class TeamController extends Controller
{
    public function index($leagueId)
    {
        try {
            $league = League::with('teams')->findOrFail($leagueId);

            return TeamResource::collection($league->teams);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
    
    public function all(): JsonResponse
    {
        try {
            $teams = Team::with(['league', 'sport'])->get();

            return response()->json([
                'status' => 'success',
                'data' => $teams
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
