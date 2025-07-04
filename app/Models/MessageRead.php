<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MessageRead extends Model
{
    protected $fillable = ['message_id', 'user_id', 'read_at'];
    public $timestamps = false;
}