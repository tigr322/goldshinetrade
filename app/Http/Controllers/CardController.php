<?php
// app/Http/Controllers/CardController.php
namespace App\Http\Controllers;
use App\Models\UserCard;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\User;
use Illuminate\Support\Facades\Gate;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
class CardController extends Controller
{
    use AuthorizesRequests;

    
    public function index()
    {
        $cards = Auth::user()->cards;

        return Inertia::render('Cards/Cards', [
            'cards' => $cards,
        ]);
    }

    public function create()
    {
        return Inertia::render('Cards/Add');
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'number' => 'required|string|min:16|max:19',
            'expiry' => 'required|string',
            'type' => 'required|string',
        ]);
        /** @var User $user */
        // Сброс primary, если текущая становится основной
        if ($request->primary) {
            $user = Auth::user();
            $user->cards()->update(['primary' => false]);
        }

        Auth::user()->cards()->create([
            'name' => $request->name,
            'number' => substr($request->number, -4), // сохраняем только последние 4 цифры
            'expiry' => $request->expiry,
            'type' => $request->type,
            'primary' => $request->primary ?? false,
        ]);

        return redirect()->route('cards.index')->with('success', 'Карта добавлена');
    }

    public function destroy(UserCard $card)
    {
        $card->delete();
        return back()->with('success', 'Карта удалена');
    }
}