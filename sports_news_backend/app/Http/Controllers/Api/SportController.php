<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Sport;

class SportController extends Controller
{
    public function index()
    {
        try {
            $sports = Sport::all();
            return response()->json([
                'status' => 'success',
                'data' => $sports
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}