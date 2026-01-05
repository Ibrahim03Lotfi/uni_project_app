<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Sport;
use Illuminate\Http\Request;

class SportController extends Controller
{
    // Get all sports
    public function index()
    {
        $sports = Sport::select('id', 'name', 'icon_url')->get();
        
        // Convert icon_url to full URL if it's stored locally
        $sports->transform(function ($sport) {
            if ($sport->icon_url && !filter_var($sport->icon_url, FILTER_VALIDATE_URL)) {
                $sport->icon_url = url('storage/' . $sport->icon_url);
            }
            return $sport;
        });
        
        return response()->json($sports);
    }
}