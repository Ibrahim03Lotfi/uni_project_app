<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\League;
use App\Models\Sport;
use Illuminate\Http\JsonResponse;

class LeagueController extends Controller
{
    public function index($sportId): JsonResponse
    {
        try {
            $sport = Sport::findOrFail($sportId);
            $leagues = $sport->leagues()->get();

            return response()->json([
                'status' => 'success',
                'data' => $leagues
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
