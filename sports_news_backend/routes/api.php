<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserPreferenceController;
use App\Http\Controllers\SportController;

Route::get('/test', function () {
    return response()->json(['message' => 'API is working!']);
});

// Public routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);

    // Preferences routes (protected)
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/preferences', [UserPreferenceController::class, 'index']);
    Route::post('/preferences/sports', [UserPreferenceController::class, 'updateSports']);
    Route::post('/preferences/teams', [UserPreferenceController::class, 'updateTeams']);
    Route::post('/preferences/leagues', [UserPreferenceController::class, 'updateLeagues']);
    Route::post('/preferences/players', [UserPreferenceController::class, 'updatePlayers']);
});

// Public sports endpoint
Route::get('/sports', [SportController::class, 'index']);
});