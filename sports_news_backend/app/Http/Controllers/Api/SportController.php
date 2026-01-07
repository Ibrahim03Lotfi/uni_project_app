<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Sport;
use App\Http\Resources\SportResource;

class SportController extends Controller
{
    public function index()
    {
        try {
            $sports = Sport::all();
            return SportResource::collection($sports);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}