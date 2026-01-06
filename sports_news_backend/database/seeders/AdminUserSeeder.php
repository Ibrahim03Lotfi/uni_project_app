<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AdminUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    // database/seeders/AdminUserSeeder.php
    public function run(): void
    {
        User::updateOrCreate(
            ['email' => 'admin@app.com'],
            [
                'name' => 'Super Admin',
                'password' => Hash::make('password'),
                'role' => \App\UserRole::SUPER_ADMIN->value,
                'email_verified_at' => now(),
            ]
        );

        // Create a regular Admin assigned to Football (ID: 1)
        // Ensure Sport with ID 1 exists (SportsSeeder must run first)
        User::updateOrCreate(
            ['email' => 'football_admin@app.com'],
            [
                'name' => 'Football Admin',
                'password' => Hash::make('password'),
                'role' => \App\UserRole::ADMIN->value,
                'assigned_sport_id' => 1, // Assuming ID 1 is Football
                'email_verified_at' => now(),
            ]
        );
    }
}
