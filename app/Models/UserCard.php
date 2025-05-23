<?php

namespace App\Models;



use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class UserCard extends Model
{
    use HasFactory;

    protected $fillable = ['user_id', 'name', 'number', 'expiry', 'type', 'primary'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
