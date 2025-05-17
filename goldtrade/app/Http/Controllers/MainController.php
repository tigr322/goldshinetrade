<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;
use Illuminate\Support\Facades\Auth;

class MainController extends Controller
{
    public function index(): Response 
    {
      

        return Inertia::render('Dashboard', [
            'user' => Auth::user(),
        ]);
    }
}
