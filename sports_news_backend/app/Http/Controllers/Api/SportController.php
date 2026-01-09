<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Sport;
use App\Http\Resources\SportResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\UserRole;

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

    /**
     * Create a new sport (Super Admin only)
     */
    public function store(Request $request)
    {
        $user = $request->user();

        // Only Super Admin can create sports
        if (!$user->isSuperAdmin()) {
            return response()->json(['message' => 'Unauthorized. Super Admin access required.'], 403);
        }

        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255|unique:sports',
            'description' => 'nullable|string',
            'icon' => 'nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $sport = Sport::create([
            'name' => $request->name,
            'description' => $request->description,
            'icon' => $request->icon,
        ]);

        return response()->json([
            'message' => 'Sport created successfully',
            'sport' => new SportResource($sport)
        ], 201);
    }

    /**
     * Update a sport (Super Admin only)
     */
    public function update(Request $request, $id)
    {
        $user = $request->user();

        // Only Super Admin can update sports
        if (!$user->isSuperAdmin()) {
            return response()->json(['message' => 'Unauthorized. Super Admin access required.'], 403);
        }

        $sport = Sport::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255|unique:sports,name,' . $id,
            'description' => 'nullable|string',
            'icon' => 'nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $sport->update([
            'name' => $request->name,
            'description' => $request->description,
            'icon' => $request->icon,
        ]);

        return response()->json([
            'message' => 'Sport updated successfully',
            'sport' => new SportResource($sport)
        ]);
    }

    /**
     * Delete a sport (Super Admin only)
     */
    public function destroy(Request $request, $id)
    {
        $user = $request->user();

        // Only Super Admin can delete sports
        if (!$user->isSuperAdmin()) {
            return response()->json(['message' => 'Unauthorized. Super Admin access required.'], 403);
        }

        $sport = Sport::findOrFail($id);

        try {
            // Check if sport has associated leagues, teams, or articles
            if ($sport->leagues()->count() > 0) {
                return response()->json([
                    'message' => 'Cannot delete sport. It has associated leagues.'
                ], 422);
            }

            if ($sport->teams()->count() > 0) {
                return response()->json([
                    'message' => 'Cannot delete sport. It has associated teams.'
                ], 422);
            }

            if ($sport->newsArticles()->count() > 0) {
                return response()->json([
                    'message' => 'Cannot delete sport. It has associated news articles.'
                ], 422);
            }

            $sport->delete();

            return response()->json([
                'message' => 'Sport deleted successfully'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error deleting sport: ' . $e->getMessage()
            ], 500);
        }
    }
}