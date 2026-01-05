<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\League;
use App\Models\Team;
use Illuminate\Http\JsonResponse;

class TeamController extends Controller
{
    public function index($leagueId): JsonResponse
    {
        try {
            $league = League::with('teams')->findOrFail($leagueId);
            
            return response()->json([
                'status' => 'success',
                'data' => $league->teams
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}