<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Sport;
use App\Models\Team;
use App\Models\League;
use App\Models\Player;
use Illuminate\Http\Request;

class UserPreferenceController extends Controller
{
    // Get all user preferences
    public function index(Request $request)
    {
        $user = $request->user();
        
        return response()->json([
            'sports' => $user->preferredSports()->get(),
            'teams' => $user->preferredTeams()->get(),
            'leagues' => $user->preferredLeagues()->get(),
            'players' => $user->preferredPlayers()->get(),
        ]);
    }

    // Update sports preferences
    public function updateSports(Request $request)
    {
        $request->validate([
            'sport_ids' => 'required|array',
            'sport_ids.*' => 'exists:sports,id',
        ]);

        $user = $request->user();
        $user->preferredSports()->sync($request->sport_ids);

        return response()->json([
            'message' => 'Sports preferences updated successfully',
            'sports' => $user->preferredSports()->get(),
        ]);
    }

    // Update teams preferences
    public function updateTeams(Request $request)
    {
        $request->validate([
            'team_ids' => 'required|array',
            'team_ids.*' => 'exists:teams,id',
        ]);

        $user = $request->user();
        $user->preferredTeams()->sync($request->team_ids);

        return response()->json([
            'message' => 'Teams preferences updated successfully',
            'teams' => $user->preferredTeams()->get(),
        ]);
    }

    // Update leagues preferences
    public function updateLeagues(Request $request)
    {
        $request->validate([
            'league_ids' => 'required|array',
            'league_ids.*' => 'exists:leagues,id',
        ]);

        $user = $request->user();
        $user->preferredLeagues()->sync($request->league_ids);

        return response()->json([
            'message' => 'Leagues preferences updated successfully',
            'leagues' => $user->preferredLeagues()->get(),
        ]);
    }

    // Update players preferences
    public function updatePlayers(Request $request)
    {
        $request->validate([
            'player_ids' => 'required|array',
            'player_ids.*' => 'exists:players,id',
        ]);

        $user = $request->user();
        $user->preferredPlayers()->sync($request->player_ids);

        return response()->json([
            'message' => 'Players preferences updated successfully',
            'players' => $user->preferredPlayers()->get(),
        ]);
    }

    // Save all preferences at once
    public function saveAll(Request $request)
    {
        $request->validate([
            'sport_ids' => 'nullable|array',
            'sport_ids.*' => 'exists:sports,id',
            'team_ids' => 'nullable|array',
            'team_ids.*' => 'exists:teams,id',
        ]);

        $user = $request->user();

        // Sync sports preferences
        if ($request->has('sport_ids')) {
            $user->preferredSports()->sync($request->sport_ids);
        }

        // Sync teams preferences
        if ($request->has('team_ids')) {
            $user->preferredTeams()->sync($request->team_ids);
        }

        return response()->json([
            'message' => 'Preferences saved successfully',
            'sports' => $user->preferredSports()->get(),
            'teams' => $user->preferredTeams()->get(),
        ]);
    }
}