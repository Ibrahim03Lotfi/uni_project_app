<?php

// Simple test to check if preferences are working
require_once 'vendor/autoload.php';

use App\Models\User;
use App\Models\Sport;

// Test database connection and relationships
try {
    // Get a test user (you'll need to adjust this)
    $user = User::first();
    
    if ($user) {
        echo "Found user: " . $user->name . " (ID: " . $user->id . ")\n";
        
        // Check if user has any preferred sports
        $preferredSports = $user->preferredSports;
        echo "Preferred sports count: " . $preferredSports->count() . "\n";
        
        // Try to add a sport preference
        $football = Sport::find(1);
        if ($football) {
            echo "Found football sport: " . $football->name . "\n";
            
            // Check if already following
            $isFollowing = $user->preferredSports()->where('sport_id', 1)->exists();
            echo "Already following football: " . ($isFollowing ? 'Yes' : 'No') . "\n";
            
            if (!$isFollowing) {
                $user->preferredSports()->attach(1);
                echo "Attached football to user preferences\n";
                
                // Check again
                $newCount = $user->preferredSports()->count();
                echo "New preferred sports count: " . $newCount . "\n";
            }
        }
        
        // Check all pivot tables
        echo "\nChecking pivot tables:\n";
        echo "User-Sports: " . \DB::table('user_sports')->where('user_id', $user->id)->count() . " records\n";
        echo "User-Leagues: " . \DB::table('user_leagues')->where('user_id', $user->id)->count() . " records\n";
        echo "User-Teams: " . \DB::table('user_teams')->where('user_id', $user->id)->count() . " records\n";
        echo "User-Players: " . \DB::table('user_players')->where('user_id', $user->id)->count() . " records\n";
        
    } else {
        echo "No users found in database\n";
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
