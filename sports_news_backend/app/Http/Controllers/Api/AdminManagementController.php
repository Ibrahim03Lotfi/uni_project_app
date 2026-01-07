<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Sport;
use App\Http\Resources\UserResource;
use App\Http\Resources\SportResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\UserRole;

class AdminManagementController extends Controller
{
    /**
     * Create a new admin user (Super Admin only)
     */
    public function createAdmin(Request $request)
    {
        $user = $request->user();

        // Only Super Admin can create admins
        if (!$user->isSuperAdmin()) {
            return response()->json(['message' => 'Unauthorized. Super Admin access required.'], 403);
        }

        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
            'assigned_sport_id' => 'required|exists:sports,id',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $admin = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => UserRole::ADMIN->value,
            'assigned_sport_id' => $request->assigned_sport_id,
            'email_verified_at' => now(),
        ]);

        return response()->json([
            'message' => 'Admin created successfully',
            'admin' => new UserResource($admin->load('assignedSport'))
        ], 201);
    }

    /**
     * Delete a user (Super Admin only)
     */
    public function deleteUser($id, Request $request)
    {
        $user = $request->user();

        // Only Super Admin can delete users
        if (!$user->isSuperAdmin()) {
            return response()->json(['message' => 'Unauthorized. Super Admin access required.'], 403);
        }

        // Prevent self-deletion
        if ($user->id == $id) {
            return response()->json(['message' => 'Cannot delete your own account.'], 403);
        }

        $userToDelete = User::findOrFail($id);
        $userToDelete->delete();

        return response()->json([
            'message' => 'User deleted successfully'
        ]);
    }

    /**
     * Get all users (Super Admin only)
     */
    public function getUsers(Request $request)
    {
        $user = $request->user();

        // Only Super Admin can view all users
        if (!$user->isSuperAdmin()) {
            return response()->json(['message' => 'Unauthorized. Super Admin access required.'], 403);
        }

        $users = User::with('assignedSport')
            ->orderBy('role')
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return UserResource::collection($users);
    }

    /**
     * Get all sports for admin assignment
     */
    public function getSportsForAssignment(Request $request)
    {
        $user = $request->user();

        // Only Super Admin can assign sports
        if (!$user->isSuperAdmin()) {
            return response()->json(['message' => 'Unauthorized. Super Admin access required.'], 403);
        }

        $sports = Sport::all();

        return SportResource::collection($sports);
    }
}
