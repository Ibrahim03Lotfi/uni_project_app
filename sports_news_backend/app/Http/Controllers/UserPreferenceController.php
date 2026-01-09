<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Sport;
use App\Models\Team;
use App\Models\League;
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
        \Log::info('updateTeams called with data: ', $request->all());
        
        $request->validate([
            'team_ids' => 'required|array',
            'team_ids.*' => 'exists:teams,id',
        ]);

        $user = $request->user();
        \Log::info('User ID: ' . $user->id);
        
        $user->preferredTeams()->sync($request->team_ids);
        
        \Log::info('Teams synced successfully');

        return response()->json([
            'message' => 'Teams preferences updated successfully',
            'teams' => $user->preferredTeams()->get(),
        ]);
    }

    // Update leagues preferences
    public function updateLeagues(Request $request)
    {
        \Log::info('updateLeagues called with data: ', $request->all());
        
        $request->validate([
            'league_ids' => 'required|array',
            'league_ids.*' => 'exists:leagues,id',
        ]);

        $user = $request->user();
        \Log::info('User ID: ' . $user->id);
        
        $user->preferredLeagues()->sync($request->league_ids);
        
        \Log::info('Leagues synced successfully');

        return response()->json([
            'message' => 'Leagues preferences updated successfully',
        ]);
    }

    // Update players preferences
    public function updatePlayers(Request $request)
    {
        \Log::info('updatePlayers called with data: ', $request->all());
        
        $request->validate([
            'player_ids' => 'required|array',
            'player_ids.*' => 'exists:players,id',
        ]);

        $user = $request->user();
        \Log::info('User ID: ' . $user->id);
        
        $user->preferredPlayers()->sync($request->player_ids);
        
        \Log::info('Players synced successfully');

        return response()->json([
            'message' => 'Players preferences updated successfully',
        ]);
    }

    // Unfollow methods
    public function unfollowSport(Request $request, $sportId)
    {
        $user = $request->user();
        $user->preferredSports()->detach($sportId);

        return response()->json([
            'message' => 'Sport unfollowed successfully',
        ]);
    }

    public function unfollowLeague(Request $request, $leagueId)
    {
        $user = $request->user();
        $user->preferredLeagues()->detach($leagueId);

        return response()->json([
            'message' => 'League unfollowed successfully',
        ]);
    }

    public function unfollowTeam(Request $request, $teamId)
    {
        $user = $request->user();
        $user->preferredTeams()->detach($teamId);

        return response()->json([
            'message' => 'Team unfollowed successfully',
        ]);
    }

    public function unfollowPlayer(Request $request, $playerId)
    {
        $user = $request->user();
        $user->preferredPlayers()->detach($playerId);

        return response()->json([
            'message' => 'Player unfollowed successfully',
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
            'league_ids' => 'nullable|array',
            'league_ids.*' => 'exists:leagues,id',
            'player_ids' => 'nullable|array',
            'player_ids.*' => 'exists:players,id',
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

        // Sync leagues preferences
        if ($request->has('league_ids')) {
            $user->preferredLeagues()->sync($request->league_ids);
        }

        // Sync players preferences
        if ($request->has('player_ids')) {
            $user->preferredPlayers()->sync($request->player_ids);
        }

        return response()->json([
            'message' => 'Preferences saved successfully',
            'sports' => $user->preferredSports()->get(),
            'teams' => $user->preferredTeams()->get(),
            'leagues' => $user->preferredLeagues()->get(),
            'players' => $user->preferredPlayers()->get(),
        ]);
    }
}
