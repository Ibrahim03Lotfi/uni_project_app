<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckRoleMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     * @param  string  $role
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function handle(Request $request, Closure $next, string $role): Response
    {
        $user = $request->user();
        
        if (!$user) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        // Check if user has the required role
        switch ($role) {
            case 'admin':
                if (!$user->isAdmin()) {
                    return response()->json(['message' => 'Unauthorized. Admin access required.'], 403);
                }
                break;
            case 'super_admin':
                if (!$user->isSuperAdmin()) {
                    return response()->json(['message' => 'Unauthorized. Super Admin access required.'], 403);
                }
                break;
            case 'user':
                if ($user->role !== \App\UserRole::USER->value) {
                    return response()->json(['message' => 'Unauthorized. User access required.'], 403);
                }
                break;
            default:
                return response()->json(['message' => 'Invalid role specified.'], 403);
        }

        return $next($request);
    }
}
