<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Withdrawal;
use Inertia\Inertia;

class AdminWithdrawalController extends Controller
{
    public function index()
    {
        $withdrawals = Withdrawal::with('user')
            ->latest()
            ->paginate(20)
            ->through(function ($w) {
                return [
                    'id' => $w->id,
                    'user' => [
                        'id' => $w->user?->id,
                        'name' => $w->user?->name,
                        'email' => $w->user?->email,
                    ],
                    'amount' => (float) $w->amount,
                    'method' => $w->method,
                    'details' => $w->details,
                    'status' => $w->status,
                    'created_at' => $w->created_at->toDateTimeString(),
                ];
            });

        return Inertia::render('Admin/Withdrawals/Index', [
            'withdrawals' => $withdrawals,
        ]);
    }
}

