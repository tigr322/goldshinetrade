<?php
namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class AdminOrModer
{
    public function handle(Request $request, Closure $next)
    {
        $user = auth()->user();
        if (!$user || !($user->hasRole('admin') || $user->hasRole('moderator'))) {
            abort(403);
        }

        return $next($request);
    }
}