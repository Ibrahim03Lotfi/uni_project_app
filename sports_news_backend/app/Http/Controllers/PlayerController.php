<?php

namespace App\Http\Controllers;

use App\Models\Player;
use App\Models\Team;
use Illuminate\Http\Request;

class PlayerController extends Controller
{
    public function index($teamId)
    {
        $team = Team::find($teamId);
        
        if (!$team) {
            return response()->json([
                'status' => 'error',
                'message' => 'Team not found'
            ], 404);
        }

        $players = $team->players()->with(['sport', 'team'])->get();

        return response()->json([
            'status' => 'success',
            'data' => $players
        ]);
    }

    public function all()
    {
        $players = Player::with(['sport', 'team'])->get();

        return response()->json([
            'status' => 'success',
            'data' => $players
        ]);
    }
}
