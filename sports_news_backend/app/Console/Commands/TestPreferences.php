<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;

class TestPreferences extends Command
{
    protected $signature = 'test:preferences';
    protected $description = 'Test user preferences';

    public function handle()
    {
        $this->info('Testing user preferences...');
        
        $user = User::first();
        if ($user) {
            $this->info("Found user: {$user->name} (ID: {$user->id})");
            
            $preferredSports = $user->preferredSports;
            $this->info("Preferred sports count: " . $preferredSports->count());
            
            foreach ($preferredSports as $sport) {
                $this->info("  - {$sport->name} (ID: {$sport->id})");
            }
            
            // Check pivot table directly
            $pivotCount = \DB::table('user_sports')->where('user_id', $user->id)->count();
            $this->info("Pivot table records: " . $pivotCount);
            
        } else {
            $this->error('No users found');
        }
        
        return 0;
    }
}
