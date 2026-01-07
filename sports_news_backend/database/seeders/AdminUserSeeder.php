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
        User::updateOrCreate(
            ['email' => 'football_admin@app.com'],
            [
                'name' => 'Football Admin',
                'password' => Hash::make('password'),
                'role' => \App\UserRole::ADMIN->value,
                'assigned_sport_id' => 1,
                'email_verified_at' => now(),
            ]
        );

        // Basketball Admin (ID: 2)
        User::updateOrCreate(
            ['email' => 'basketball_admin@app.com'],
            [
                'name' => 'Basketball Admin',
                'password' => Hash::make('password'),
                'role' => \App\UserRole::ADMIN->value,
                'assigned_sport_id' => 2,
                'email_verified_at' => now(),
            ]
        );

        // Tennis Admin (ID: 3)
        User::updateOrCreate(
            ['email' => 'tennis_admin@app.com'],
            [
                'name' => 'Tennis Admin',
                'password' => Hash::make('password'),
                'role' => \App\UserRole::ADMIN->value,
                'assigned_sport_id' => 3,
                'email_verified_at' => now(),
            ]
        );

        // Volleyball Admin (ID: 4)
        User::updateOrCreate(
            ['email' => 'volleyball_admin@app.com'],
            [
                'name' => 'Volleyball Admin',
                'password' => Hash::make('password'),
                'role' => \App\UserRole::ADMIN->value,
                'assigned_sport_id' => 4,
                'email_verified_at' => now(),
            ]
        );
    }
}
