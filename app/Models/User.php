<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Relations\HasMany;
class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable;

    /**в
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name', 'email', 'password', 'phone', 'is_verified', 'balance_real', 'rating', 'adress',
    ];
    public function offers(): HasMany
    {
        return $this->hasMany(Offer::class);
    }

    public function deals(): HasMany
    {
        return $this->hasMany(Deal::class, 'buyer_id');
    }

    public function messages(): HasMany
    {
        return $this->hasMany(Message::class);
    }

    public function reviewsGiven(): HasMany
    {
        return $this->hasMany(Review::class, 'from_user_id');
    }

    public function reviewsReceived(): HasMany
    {
        return $this->hasMany(Review::class, 'to_user_id');
    }

    public function withdrawals(): HasMany
    {
        return $this->hasMany(Withdrawal::class);
    }
    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
    
}
