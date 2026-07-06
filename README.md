# goldshinetrade — Gaming Currency Exchange Marketplace

<p align="center">
  <img src="https://img.shields.io/badge/Laravel-12-FF2D20?style=flat-square&logo=laravel" />
  <img src="https://img.shields.io/badge/PHP-8.3-777BB4?style=flat-square&logo=php" />
  <img src="https://img.shields.io/badge/Vue-3-4FC08D?style=flat-square&logo=vuedotjs" />
  <img src="https://img.shields.io/badge/Inertia.js-2-9553E9?style=flat-square" />
  <img src="https://img.shields.io/badge/Docker-Ready-2496ED?style=flat-square&logo=docker" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" />
</p>

> 📸 **Screenshots coming soon**

Full-stack marketplace for exchanging in-game currencies for real money. Escrow system with frozen funds, real-time messaging (Pusher WebSockets), CKassa payment gateway integration, social auth (VK ID + Google OAuth), Spatie role-based access control, and admin panel — all Docker-deployed.

---

## ✨ Features

- **Escrow System** — Buyer places order → funds frozen → seller delivers → buyer confirms → funds released. Dispute resolution workflow included.
- **Real-Time Chat** — Pusher WebSockets for instant messaging between buyers and sellers within deals.
- **CKassa Payment Integration** — Production payment gateway integration for deposits and withdrawals.
- **Social Authentication** — Login via VK ID (custom OIDC) and Google OAuth2.
- **Role-Based Access** — Spatie Laravel Permissions for admin, seller, and buyer roles.
- **Responsive SPA** — Vue 3 + Inertia.js 2 + Tailwind CSS 3 with Headless UI components.
- **Admin Panel** — Manage offers, users, withdrawals; dashboard with metrics.
- **Docker Deployment** — PHP-FPM 8.3 + Nginx Alpine, Docker Compose production-ready.

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Backend** | Laravel 12, PHP 8.3 |
| **Auth** | Fortify + Jetstream 5 + Sanctum 4 |
| **RBAC** | Spatie Laravel Permission v6 |
| **Database** | MySQL 8 |
| **Payments** | CKassa API |
| **Real-Time** | Pusher + Laravel Echo |
| **Social Auth** | Laravel Socialite (VK ID, Google) |
| **Frontend** | Vue 3 + Inertia.js 2 + Tailwind CSS 3 |
| **UI** | Headless UI + Heroicons |
| **Build** | Vite 6 |
| **Containerization** | Docker Compose + PHP-FPM 8.3 + Nginx Alpine |
| **Queue** | Laravel Horizon + Redis |
| **Mail** | Mailgun |

---

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose
- PHP 8.2+ with Composer (for local dev)
- Node.js 20+ with npm

### Setup

```bash
# 1. Clone
git clone https://github.com/tigr322/goldshinetrade.git
cd goldshinetrade

# 2. Install PHP dependencies
composer install

# 3. Install JS dependencies
npm install

# 4. Configure environment
cp .env.example .env
php artisan key:generate

# 5. Edit .env with your:
#    - DB credentials
#    - Pusher keys (PUSHER_APP_ID, PUSHER_APP_KEY, PUSHER_APP_SECRET)
#    - CKassa credentials (CKASSA_SHOP_TOKEN, CKASSA_SEC_KEY)
#    - VK ID credentials (VKONTAKTE_CLIENT_ID, VKONTAKTE_CLIENT_SECRET)
#    - Google OAuth credentials
#    - Mailgun credentials

# 6. Docker up
docker compose up -d

# 7. Migrate & seed
php artisan migrate --seed

# 8. Build frontend
npm run build

# Visit http://localhost
```

---

## 🏗️ Architecture

### Escrow Flow

```
1. Seller creates an Offer (game, server, currency, price)
2. Buyer accepts → Deal created, funds frozen
3. Seller delivers in-game currency
4. Buyer confirms receipt → funds released to seller
5. If disputed → admin mediates
```

### Key Models

| Model | Purpose |
|-------|---------|
| `Game` / `Server` | Game catalog |
| `Offer` | Seller's listing |
| `Deal` | Active transaction with escrow state |
| `Message` | Real-time deal chat |
| `Payment` / `Withdrawal` | Financial operations |
| `Review` | Buyer/seller feedback |

### Directory Structure

```
goldshinetrade/
├── app/
│   ├── Actions/         Fortify + Jetstream actions
│   ├── Events/          BalanceUpdated, MessageSent, etc.
│   ├── Http/Controllers/
│   │   ├── Admin/       Dashboard, Users, Offers, Withdrawals
│   │   ├── Auth/        SocialController, VkIdController
│   │   └── Trade/       TradeController
│   ├── Models/          Game, Deal, Offer, Payment, etc. (14 models)
│   ├── Policies/        Authorization rules
│   └── Services/        CkassaService, EncryptionService
├── database/migrations/ 17 migration files
├── resources/js/        Vue 3 SPA (Inertia pages)
├── routes/
│   ├── web.php          Main application routes
│   ├── api.php          REST API
│   └── channels.php     Pusher broadcasting
├── docker/              PHP-FPM + Nginx configs
└── tests/               Feature + Unit tests
```

---

## 🇷🇺 Русский

**goldshinetrade** — полноценный маркетплейс для обмена внутриигровых валют на реальные деньги. Платформа включает escrow-систему с заморозкой средств, чат в реальном времени через Pusher, интеграцию платёжного шлюза CKassa, авторизацию через VK ID и Google, систему ролей Spatie и админ-панель. Развёртывается через Docker Compose.

**Стек**: Laravel 12, Vue 3 + Inertia.js, MySQL, CKassa, Pusher, Docker.

---

## 📄 License

MIT © [Tigran Adamyan](https://github.com/tigr322)
