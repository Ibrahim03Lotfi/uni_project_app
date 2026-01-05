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
}
}
