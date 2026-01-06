<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserPreferenceController;
use App\Http\Controllers\Api\SportController;
use App\Http\Controllers\Api\LeagueController;
use App\Http\Controllers\Api\TeamController;
use App\Http\Controllers\Api\NewsArticleController;

Route::get('/test', function () {
    return response()->json(['message' => 'API is working!']);
});

// Public routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);

// Public API endpoints
Route::get('/sports', [SportController::class, 'index']);
Route::get('/sports/{sport}/leagues', [LeagueController::class, 'index']);
Route::get('/leagues/{league}/teams', [TeamController::class, 'index']);

// Protected routes (require authentication)
Route::middleware('auth:sanctum')->group(function () {
    // Auth routes
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);

    // Preferences routes
    Route::prefix('preferences')->group(function () {
        Route::get('/', [UserPreferenceController::class, 'index']);
        Route::post('/sports', [UserPreferenceController::class, 'updateSports']);
        Route::post('/teams', [UserPreferenceController::class, 'updateTeams']);
        Route::post('/leagues', [UserPreferenceController::class, 'updateLeagues']);
        Route::post('/players', [UserPreferenceController::class, 'updatePlayers']);
    });

    // News/Posts routes
    Route::get('/feed', [NewsArticleController::class, 'index']); // User News Feed
    Route::get('/posts/search', [NewsArticleController::class, 'search']); // Search
    Route::post('/posts', [NewsArticleController::class, 'store']); // Create News
});
