-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 28 2025 г., 20:03
-- Версия сервера: 8.0.42-0ubuntu0.24.04.1
-- Версия PHP: 8.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `goldshinetrade`
--

-- --------------------------------------------------------

--
-- Структура таблицы `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('goldshinetrade_cache_albertadaman70@gmail.com|147.78.182.224', 'i:3;', 1748284803),
('goldshinetrade_cache_albertadaman70@gmail.com|147.78.182.224:timer', 'i:1748284803;', 1748284803),
('goldshinetrade_cache_spatie.permission.cache', 'a:3:{s:5:\"alias\";a:0:{}s:11:\"permissions\";a:0:{}s:5:\"roles\";a:0:{}}', 1748499533);

-- --------------------------------------------------------

--
-- Структура таблицы `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Пополнение кошелька Steam', NULL, NULL),
(2, 'Игры', NULL, NULL),
(3, 'Прочее', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `deals`
--

CREATE TABLE `deals` (
  `id` bigint UNSIGNED NOT NULL,
  `offer_id` bigint UNSIGNED NOT NULL,
  `buyer_id` bigint UNSIGNED NOT NULL,
  `payment_method_id` bigint UNSIGNED DEFAULT NULL,
  `quantity` int NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('pending','paid','completed','disputed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `funds_frozen` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `buyer_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `seller_confirmed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `deals`
--

INSERT INTO `deals` (`id`, `offer_id`, `buyer_id`, `payment_method_id`, `quantity`, `total_price`, `status`, `funds_frozen`, `created_at`, `updated_at`, `buyer_confirmed`, `seller_confirmed`) VALUES
(1, 2, 1, 1, 1000, 10000.00, 'pending', 0, '2025-05-23 10:33:45', '2025-05-23 10:33:45', 0, 0),
(3, 4, 1, 1, 1000000, 10000000.00, 'pending', 0, '2025-05-23 21:22:24', '2025-05-23 21:22:24', 0, 0),
(4, 3, 1, 1, 1000000, 12000000.00, 'pending', 0, '2025-05-23 21:22:44', '2025-05-23 21:22:44', 0, 0),
(7, 3, 1, 2, 1, 12.00, 'pending', 0, '2025-05-25 17:44:05', '2025-05-25 17:44:05', 0, 0),
(8, 3, 1, 1, 10, 120.00, 'pending', 0, '2025-05-25 18:45:29', '2025-05-25 18:45:29', 0, 0),
(9, 3, 1, 1, 100, 1200.00, 'pending', 0, '2025-05-25 19:08:10', '2025-05-25 19:08:10', 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `games`
--

CREATE TABLE `games` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `game_type_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `games`
--

INSERT INTO `games` (`id`, `name`, `category_id`, `game_type_id`, `created_at`, `updated_at`) VALUES
(1, 'World of Warcraft', 2, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `game_types`
--

CREATE TABLE `game_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `game_types`
--

INSERT INTO `game_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'MMORPG', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` bigint UNSIGNED NOT NULL,
  `deal_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `messages`
--

INSERT INTO `messages` (`id`, `deal_id`, `user_id`, `content`, `created_at`, `updated_at`) VALUES
(1, 8, 1, 'dsds', '2025-05-25 18:46:19', '2025-05-25 18:46:19'),
(2, 9, 1, 'Как дела?', '2025-05-25 19:08:21', '2025-05-25 19:08:21');

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_05_20_162027_new_db', 1),
(5, '2025_05_20_180021_create_permission_tables', 1),
(6, '2025_05_23_174441_create_user_cards_table', 2),
(7, '2025_05_25_165656_add_confirmations_to_deals_table', 3),
(8, '2025_05_26_153753_userphone', 4);

-- --------------------------------------------------------

--
-- Структура таблицы `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(3, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 3),
(2, 'App\\Models\\User', 4);

-- --------------------------------------------------------

--
-- Структура таблицы `offers`
--

CREATE TABLE `offers` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `game_id` bigint UNSIGNED DEFAULT NULL,
  `server_id` bigint UNSIGNED DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `game_category_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `offers`
--

INSERT INTO `offers` (`id`, `user_id`, `category_id`, `game_id`, `server_id`, `title`, `description`, `price`, `quantity`, `is_active`, `created_at`, `updated_at`, `game_category_id`) VALUES
(1, 1, 2, 1, 1, 'Голда', 'Пиши ник персонажа! Цена за 1000 голды', 100.00, 1000000, 1, '2025-05-23 09:48:38', '2025-05-23 09:48:38', NULL),
(2, 1, 1, NULL, NULL, 'Пополню стим кошелек', 'Кидайте логин и пароль стим кошелька, захожу и пооплняю. Казахский стим. Цена за Тенге', 10.00, 999000, 1, '2025-05-23 09:51:40', '2025-05-23 10:33:45', NULL),
(3, 1, 2, 1, 1, 'Продам голду', 'Вармейн Лордерон Орда\nпишите ник', 12.00, 8999889, 1, '2025-05-23 16:12:42', '2025-05-25 19:08:10', NULL),
(4, 1, 2, 1, 1, 'продам голду', 'Цена за 1000', 10.00, 0, 0, '2025-05-23 17:36:38', '2025-05-23 21:22:24', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `name`, `details`, `created_at`, `updated_at`) VALUES
(1, 'Сбербанк', 'Оплата картой сбербанка', NULL, NULL),
(2, 'Т-Банк', 'Оплата картой Т-банка', '2025-05-25 10:33:32', '2025-05-25 10:33:32');

-- --------------------------------------------------------

--
-- Структура таблицы `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2025-05-24 17:03:42', '2025-05-24 17:03:42'),
(2, 'user', 'web', '2025-05-25 08:44:51', '2025-05-25 08:44:51'),
(3, 'moderator', 'web', '2025-05-25 08:44:59', '2025-05-25 08:44:59');

-- --------------------------------------------------------

--
-- Структура таблицы `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `servers`
--

CREATE TABLE `servers` (
  `id` bigint UNSIGNED NOT NULL,
  `game_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `servers`
--

INSERT INTO `servers` (`id`, `game_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'Warmane', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0bBOuLbxdw8zPnhKIVSmyhrf5usDEFs3mlqWiIcT', NULL, '185.220.101.15', 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNHpXTzBxNmVMUU1PMThGZEk0UG1vUXVIOXNpbXU3UEhVVkR5anFjRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748108346),
('0CyZSPSdslTWXFpURQHHIImVCfyOGrWye5F1zaZc', NULL, '124.236.100.56', 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiekJmWHdTWWZDVkM0V2ZXdFhoWGluWFdxZVNDR3p4M2xyU2pwY3pqTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748147652),
('0dnWNr4u0yytSUnvm6YF3KVmVvxYCTOosy9V3skR', NULL, '213.32.122.82', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS3N3aTkxRDVyYXhYckt0ZUFqMTcxWVVQbmVrSEk2bjlMWEJsMHhaeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748221693),
('0LbS7uDI4u6O6usIorcobcQwuv8IujlColweY0wG', NULL, '85.204.70.102', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSFVxcGlNaU1WNmU0WVljam1oUk05S1NVd2dIcGI1Z1llSDZKdWkxVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748070133),
('1ejz7GZ8PWekj8sGLm21nIj5rbGijsnw08MDuvkC', NULL, '84.252.147.239', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOVF6ZzdtWWluNklORVNyZXBubE5FQkZ1Q1BpVjIxQms2dDhXcHlpbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748258297),
('1GSkPlMuCzLjyWFhbwmVTbiPOqKUic9RDEE4jeK2', NULL, '173.194.96.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT1pCNDBHRVA5WEc4QW9IQjZKam5wRzZXN2ozU0JBa1hQTDY1Z1R3QyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748246658),
('1tylOhN8Raoaj2N7Ja7yRqccO9urdyVOH7dQqQH3', NULL, '2.57.122.234', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:135.0) Gecko/20100101 Firefox/135.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUHlGRkM1Q2VDNFJwNzlIRjExekN2R2Jodzc0ZHRZS3hSOTAzQTVoQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748193230),
('1Ui2B0bN1nQQcSh0KL5YDwMFfLkAuhS42xZ1r7F5', NULL, '196.251.72.211', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaUJSS21icHhNUzdNSFdhV3V2RG94VlFxU1RCRnJNdld4NHhYUHVWOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748003800),
('26Ph5vXBxkTIK2xmcGgSU0ysGaEUrqQnVSQGwIlf', 1, '217.145.224.153', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiZzRrMmc1b1I3RHFrYUtFUlFoUEw3NFJVQVE0VzlHTXllUklURXhoTiI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM0OiJodHRwczovL2dvbGRzaGluZXRyYWRlLnJ1L21lc3NhZ2VzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1748038156),
('2CEl8xMonB5IKQoVvA72GoXAQP0wV53V4W5BJUq3', NULL, '3.101.19.141', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicTJXYzkyaGF4dGU2THlMaTQ1YmNFRlZDUXNNYmh1cW9OeVdKaDFBWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748313692),
('2Iq402AoA4aWOlUjXYqq5Rmwokzm0yS8GN5wx1hR', NULL, '104.234.115.190', '\'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)\'', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNnVoRnRVSUVDZkVvTEh1NWh6M05INHF2V3NDRGNHRjI5dUhwNThHSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748163552),
('2Ly3LC3nLMxjcL7ZT1Fs90i35PKU7Dd6S1o2GNng', NULL, '77.83.84.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.66 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTXA5UTJlOWNkQ0J5VGliT0c0d0gydEpTYkZ6dXd5cVJQbFFDck5QVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748310970),
('2tSxEod7GIFTyHMbvFAwXG2SOBmQdi9poUbyg022', NULL, '176.59.73.72', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZXp4NmZFaDhBQ0d6M2dKaXJrRnd3T3l2WTNiZnhIRWNydjZGcmdkdSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748407219),
('3oMNcgzZcl57JF2BmRdcwkC2cWAgPC1LBiYdzPM4', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNG5mS0VzajVyRFNpNUI1RWhha1V1RVI3eTRGM3pEb0pCc1lFZWQyWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748135488),
('3R2wEyujH4N5ZmWQ7H6NuD2WweyBfKhfSW86Ejkz', NULL, '45.128.206.121', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Safari/605.7.23', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTXo0OW5nTWk4QWxTdW1jZWdOVXplWWhaZVAySExlUFNYeUx6RGNCRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748402134),
('3vj2zyEMQ3to78J6KfRlz4nswZ5xOTojXTgw2WVx', NULL, '35.95.78.173', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUkx0dzZYZ3l3SXRRRG9FOW9jeE1ZWlFZWW5iVjJnUUJXclZ1QTI3VyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748275240),
('45OY8dathWP1M4WU9Zd2JofVJQhzGShy9NpcLdJa', 1, '217.145.224.153', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic0JQWkdrQ3lkelczQnphWndQQ3RHTng4SHhoRWR6TGNhM1BoMHQwbCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1748067564),
('4aW2vxs0Z3OdV48WqeTJXe4Fq6pvbW72cIR99pXz', NULL, '65.49.20.67', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/101.0.4951.41 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia0U0MEpVdEh0eFMxejZySG96dHcxZmIwc3MzM1V3emZYa3MwU2J2eiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748394501),
('4I02jQjT59xMV6CGcJSRpR1p6ABAi2GZwgkCsDYF', NULL, '167.94.138.197', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT01GMWVyS0ZndlZ4aG9SQndWT2NKZHJBeERRM2RESDVUVkp4MHNrQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748389581),
('4KnrpueJz0z38hgjNfJrCyzUAEbkLlzPza9RdnQ2', NULL, '66.132.153.59', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZU1HVE1vQVZoZjdReHEwZ3hCd1hMWE9mcVdIdkE5QzdscUM0alRISCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748327219),
('4m3sHAUyijSIZxrOh3iSPxZxyubjtb9n0kzxUoEK', NULL, '193.202.80.87', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibnZGdHRSSjBzelBrNWhHN1RKVXFJQTEzMTV4eEZrSmlFTjdyRERZMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748460155),
('4nC5V1zcxCCJuxGfVxxWGroFOyfO3ohcTavQ6sau', NULL, '66.132.153.55', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibW0yUWdDQWJUMlJoTHZHcjQ5U2VueEFkRUxxWUxkN05DUEJpZ01kTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748021007),
('4OaxECUwzU3HqSTiv5oJYOOuNUM4AreWnAZjkoGQ', 1, '213.171.2.30', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkpRYmxablJxZXh0QXdtclcyTkdNTDh0TkcyTUJOSzhLaWZOQWtqdCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1748413179),
('4XLNURsSIJ69eOAbcdzddAXFLckK2kUvjAG7VEKG', NULL, '124.220.171.34', 'Mozilla/5.0 (Linux; Android 10; LIO-AN00 Build/HUAWEILIO-AN00; wv) MicroMessenger Weixin QQ AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/78.0.3904.62 XWEB/2692 MMWEBSDK/200901 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZWdFU0xWcHZvZUt1TkpYSElSSk5VV2h1SFdjbkFHcjZFWVVmZmpRUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748111414),
('55TjEKoKZk8fT1KWzoVqmFNWJkyU1yer0UEtj5US', NULL, '46.158.51.103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ3lhTWFlMU9Bd0tFOGFBQThDVkVDYnd5SHp2cWRucHQ5dEplY2tTdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748107370),
('58CjH0WU4QOfrupDi9l9ILmprOydDT8tTMo4rQqk', NULL, '46.158.113.190', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOE5LYUxvOWxlWUJHY284alVpS0xWbXBuWkNoeWZVaWVtZ0ZwQkZncCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MToiaHR0cHM6Ly9nb2xkc2hpbmV0cmFkZS5ydS9hZG1pbi9kYXNoYm9hcmQiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMToiaHR0cHM6Ly9nb2xkc2hpbmV0cmFkZS5ydS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748106594),
('5eLi8uRWMmOxb3dQcK1i87wEBzRpuliwvITD5DWZ', NULL, '45.128.206.121', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemduUVZmd0ZYU3FUa2dNcnFHUVJKUzRzajBGbnpjV3o4NDF1b0o0SiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQvbG9naW4/cmVkaXI9JTJGbmciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748402134),
('5LBOdWxmk6MGWHMw0Xn3N9zlnl4amYrZnw4Fjo2D', NULL, '176.53.216.66', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV2pTalJwR0h3RkxlWExDb0xtbHFnbGVkdjE5YURCVDk5YkhJUFd6ciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748274029),
('5lVvjoaf1vlMqykznKygj1B2TmK7mvWeegRy6PcD', NULL, '66.132.153.50', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT1FGaU1QNlpKSW1QS2NLazM2TEJxOXdXNE85T0tPQ2dEYVRHSlo5dSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748235739),
('5p2QyKQfPed9BE0xJuS0GzMlMFhuGLoz2NtAKThg', NULL, '94.247.172.129', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoienZBQkQ5RHJlcEZzN25qWVE1dWNNVWZ1RWZERk1lYVpPWmZmSnVjaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748397734),
('5Q64cptgds2tBavVBPTkKde7JARQNhhH5qmphV6P', NULL, '91.84.104.205', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM2JhNlBNMUhxeGZxU1ZqU0JabHBqZXRpbDd3RE1RemV5c29qMERlTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748407640),
('5VR0LZuoYuBPo5rE9UNdZbPEduuyvpkB4OLAp3rZ', NULL, '8.209.96.179', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2xxWWtxaFE5YzlZNUZ4WjlPNGRaMGhRRmJKYlpjNWQ4azVzNklqaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQvP2Rucz1HbllCQUFBQkFBQUFBQUFBQjJWNFlXMXdiR1VEWTI5dEFBQUJBQUUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748400499),
('62Dwin2ddvQOPucuwx3TOE0m0Gk0vHiIP0VjfV8l', NULL, '205.169.39.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWU5uejNCcEZkSld3UlBSYkpwMXNReGxiMTZyY3FOUzBJQXhVQmV5dyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748110077),
('69SpDnSbomlHGc1FwUPbxOcCF6K3moG2TtWepjFi', NULL, '40.77.167.22', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWkMyYmx4UnduQjRQR2RYc1JHOGI4bWdWMHVBYktEN09EOGx6OEJ0byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748240517),
('6g3hq953EmzKR1s4HGZjExQ5svnQawKgY402YPvt', NULL, '45.128.206.121', 'Mozilla/5.0 (Fedora; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNGdTdTNyc1MyVzhKMHhvTjU5d2JINXlvYTlHQXh4RkNmdWIyMGNiSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748402134),
('6Y4ZOLznumrqLUZEJKhwH1rQN15gd0ppeTLbkwH7', NULL, '152.32.215.244', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 9_1_1) AppleWebKit/559.36 (KHTML, like Gecko) Chrome/69.0.2155 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVGdmbUg0UDBWWVVjQU52bzFtenV0QnBrSTJldnk5ZnpIRWZib21aaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748139929),
('75RLFcEjIcktLSN6PX2Le9ugnoTOWOdVEX1kEItM', NULL, '149.154.161.249', 'TelegramBot (like TwitterBot)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoic1ZPV3NXbEFGTGtpVWt4TFVNam1vVEwwSDJvZ0hycTBwejRzUUhGeSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMjoiaHR0cHM6Ly9nb2xkc2hpbmV0cmFkZS5ydS9vZmZlcnMiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMToiaHR0cHM6Ly9nb2xkc2hpbmV0cmFkZS5ydS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748257050),
('7BwUdpdAM3FEaTPamgJEBqfgMsbr1diQU7hU5lnX', NULL, '115.231.78.11', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSEVwZE5rcjhHMUtBOXBlb3BzQW5HOGt6V1h2cHpnMVRzMUw5bHMzdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748292346),
('7GIqM8eN5MpkCel8Q59KfAlr52e0olZzL8ob5RvB', NULL, '80.85.246.74', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVHcwR3JJRnpwSHhJOGJHRUJ0UmFQMDZtUG1nUjl0Z1hMVHluN1dZSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748241205),
('7VgVBtHu4RgCvWuRuot7RcxMcffsmn2BrOHrBZME', NULL, '184.105.139.68', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYWJraTNWYmVTSXBvcERyOVNEeXZ3RWMzMkVqWGZiM2hGUFhqNzJmMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748232995),
('7yifezJjHheargFXq9kIdG5i72qQD2DcCJYpxtKo', NULL, '46.159.80.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkJNd3pxTklwUjVabzYxcER6bkk4NW5lRUhmNWgwREkyRnJqTk9PTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748106768),
('80LbwjXRXxFcYX3isyJ4pmLSkgIr0Pybtnmq9Cjf', NULL, '115.231.78.11', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUFNYaTZaUDYzeUNOdGNRZnBMcGxCNWpLbGVlaDJwQTh0WW43VElsaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748054416),
('8CkK5yGnjuaEXVngkixlpFrHZOtlibkXitBzJpxt', NULL, '85.142.100.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNDd0QnFuajVwVTZRNnJYVTNCS3l6cGtOOG84NG00Z3lRNU9nam1DWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748185929),
('8diZvC14kCPe8OPnMizedV76ddoXrQbY7BRUPDcE', NULL, '64.62.197.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.2 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT2czRkkxQm11cE5CVjhQOWd6Tm40c2VBTlpZSjhuVjduWjJzNXZuMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748134548),
('8FNXoZ0lsUvimwSo4tde0hL9vOWLzdTqIT52fWc5', NULL, '178.22.195.127', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiak5od2xUNlVjQUk3eWl2UE9rSUFQQTh2b1NvSnFVWUVBcjVDdjRHSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748038864),
('94gk888nrrNYjVtcffsQWUHInKoLKe30O2JaCw0Z', NULL, '34.76.113.184', 'python-requests/2.32.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUVhrZ2tZam5DYVJFVUhKWU9LdWNWWUROVEV2SkRlZHdBOWxxNnVVYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748003927),
('974PavAKhgqFJ5RpyuhE7h3mjFDCwAV7pposjROt', NULL, '62.109.13.133', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicWllVTlvRmZ6T0lKRUlkU2xLVzZWbU5uZzhnRjZYc2ZJMVJlOTJQTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748116504),
('9D9KpZ4izqc6fNT4D0HBJp7xtlQecJe5LjK3DC2s', NULL, '66.249.78.41', 'GoogleOther', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNEx4TW9yenplS0xCU0x5aDdZTVBrckVwSndqUEdVZ2VrWE5xM2pBRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748106404),
('9MlZh2b0gv9EzFyWlgBZPT8pe25S82dC2NHubCvB', NULL, '104.152.52.211', 'curl/7.61.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYVFzYXFidFdVV3pYbW10SExxc1ZWVERybGNzVkRaTlR3UEhkamk1TCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748190383),
('9tHCE2ByBhqioElpbcMCuGWLe8KmLiIT9kKOcoEj', NULL, '94.176.90.49', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/123.0.6312.52 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNjlOekVUYlRtUDVVR01GU0RMOTZGUHBNQTBnTk1GcmxqcHRhUVJ2SyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748111015),
('9V4CzTFtnasIM6GU9TS7kV5vRgWxQMJOkfE4rMTB', NULL, '8.209.96.179', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicWU0VUJDM01KT3RzeGRkQTVsbDVSZG1EbE42NzFYc1JVenpLcjFxdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQvP25hbWU9ZXhhbXBsZS5jb20mdHlwZT1BIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748400499),
('A4e1atRMH5bg9gIccIsoj2s4NU3O4eMoRJlG1oEZ', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZlltdlZmV0MzVTJ4RDJmaTNxWDZEUDFaY2xFOHpja0JBRDBoQm11VCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748299108),
('AbOD8lNbtYtxTncOyVzsIzcauD4ru0KF1wUAuzW6', NULL, '176.53.223.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVWVSb3VCdFZtVXNmMGtRZDUxS04yOVZZeFR0MU5KMHdITGJNVDB1RyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748011862),
('adcopUmIEI3Z18ZFtiWypTVtD58uqMporW4blV4W', NULL, '94.138.149.34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1pCc0JQODB4THhKVkh2OVd3QWIwZ2ZocTNIdkFuUnZNRWFKM3hLZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748344541),
('ahjQyKXfJFNu3VhDVdY7Z9DWb9TqTHMczt1Jae0S', NULL, '46.158.113.190', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid1hKZklFNmtmOXdCeDBkTTc1ck45bHFPMGQ4aFFad0MzcDVvZ1doeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748157613),
('aIbTwATPboG2YznSgJFzeqwWmFcMCaT0l2q2jAYY', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNmlqUVhGR2ZOazB0QnVsOUZoc2VhazJ4SmtGcmRLNmQ5ZTNtQWw4RyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748053888),
('AjvSviq1dqV5RQpFYPcSsmKkfsaebNVYwFcgeFF6', NULL, '47.91.91.123', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemVLaEZXdVo3TGRmUkVLSDgxVzRMUUlmS1ZSV2owcm1RUjloYTY5MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748389136),
('Ak6sPWFtdEopAxeoClwYUCDypibrIgKDSLwgrKqQ', NULL, '64.62.156.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.41', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidU9hMHVwb1BLNEFWaGloN2FXa040bHNBY3l1OU9rZWFGSE8zeHBNaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748047894),
('AlOBBEhajilY5HYPYipDoZ3dUsSkmt3vrn9aLiFp', NULL, '80.85.247.231', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic052Qko2ZlZOR2JHUlk4SjhxbzhxVDdxSk5VWlpXbUNZUm1CelE0SSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748072449),
('aMcC0NVdyLLhrVVgD4B6rG9o0cb169irOsTCnC1t', NULL, '45.140.53.216', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibzhWVXIza2Vrb2I1YWxuWklITzBxUDk5MnhJdGFyTUZvZ1BER2xtcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748411572),
('AoZZb2YLez1QSZBlLJRIgT03vxEO3nTH3XqM1Dhy', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRkFTSHZWQXR0Q01tZ1FiRUFkb0hqVHVXaUw0OHh6WFdRQ01oRlladiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748217405),
('APn1XMzhXcnO5ojoWR14rXTyBEhHwoJ9gVQuNDqt', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWNRb3JJODM4clpoRnpvakQ5aG1oNFlFZFU3VVhVMmcxYmF3QzVoWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748380633),
('As4U4vqS3d16jJOntkk5KgmCYYZLOcEn0UJZxenM', NULL, '45.156.128.119', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidXdyVUJGdllrN1BqSmxNa0NmMXcwWThWMGRXOTluZHJoU3BoN1owVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748135205),
('aT4qnjbB5MR8IRnTE3K8SHe401WzJL4RLWhqtWSy', NULL, '3.129.6.217', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.51', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY1J2TTdsWU9CcGc2VjZWUFFid25nSkhzdGU2RHBTa2dwcm5CQVpyNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748106404),
('aZ7f9zyg1fMgIYWmzxzJr6fkutTy3RI2G7C56MGJ', NULL, '77.75.157.233', 'Mozilla/7.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0) Gecko/20100101 Firefox/45.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWEydFBJeDVKdTF5aWh2U3pWN3ZqcWRtV0hBNnprVVJBSWNoZzBldyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748358140),
('AZDTBDPFvpjtcIm7kNHVXbHyKWmz9hzqhGjTJVdp', NULL, '54.185.134.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/109.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSTZ3NDNCU0U3dTlwZzdLbWJLNWFYQU5qcFdVd3Fnc3lhTm1zNUtRcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748252330),
('B0Fg7mEmUWglqkOsRmkcNHbOM5jlWygoKUwXlW3f', 1, '213.171.2.30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:139.0) Gecko/20100101 Firefox/139.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNVlCSEhwZXBOZjlXamJDSlNDVXVGazNiV2hQUkxEU1ZTTkFsRWN0WiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyNToiaHR0cHM6Ly9nb2xkc2hpbmV0cmFkZS5ydSI7fX0=', 1748421195),
('BI8y9B9Xs6h6keI784fAbmzokeWajXaMxblAkBub', NULL, '77.75.159.22', 'Mozilla/7.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0) Gecko/20100101 Firefox/45.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNVBkU0hrYlU3RlV1QVRVMlZRSU42cnRuSWRRRmV6OHpTeVV2RUVTUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748357754),
('BkWk0KVIjBlfSCRSeOlSuFZB5E5YoDXSJYH1tyUn', NULL, '34.116.39.104', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15 AppEngine-Google; (+http://code.google.com/appengine; appid: s~virustotalcloud)', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUHlZcGhBZlBvSG9CaGI3V0FNS1cwa3hwaHVBYzRoSGxGV3NaanJ1RCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748106413),
('BNR3Lcx1COyqhknsxlGSfKjVTI6VVHXE2nKN7hsW', NULL, '34.140.220.111', 'python-requests/2.32.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNlhOZTRiRUFYRENWbHNQWThjNWlRdlRzbDJPNjhLWEdvOEl2TG9WSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748339565),
('BxvReYjm8Ov1FR11ZCVAO4aemHGIY9bJC6WHEw1S', NULL, '205.169.39.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS3NlUXZKWHRWME0yM3NCazl6MWNjZnRXNGdNa0xZaTBpS2JldGlROSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748110334),
('c1CZEGfPl3Wly2siDcpFLoKhKDjN0klrIb1JDMfJ', NULL, '52.180.146.167', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid3ZlWXd3Y3Y5UjA4aGFGS0hGcnpzNWwxZ1VLU0tXUU1NYmI3YmdGYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748430655),
('C1fYNaVab9cIEjlkJYxGtfxSWvJ56KfkhCQqIJuB', NULL, '31.8.123.233', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSzA0bmVNRk54d1NZR3daMmN1RG5zbkQ2V1BPSnc2ZXZaR1ZDMW94ZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748390575),
('CBK2BdzKTQU686GlUOCOue8CbfkMjDjSpIXY7ubI', 2, '46.158.113.190', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4.1 Mobile/22E252 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMGd1bjlpem1lek1GbW5oRWtVd2hjaEhrRFZsbHZwdnowUGV2QmFBaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO30=', 1748080181),
('cGBlsWVjzCQUqoozrUHuUjhwI6K3oCYkzo8Z16nH', NULL, '52.187.112.47', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaXpFOTdOZ0Y0aFhHTVF4SkZJRHBQMndScThzWFNGbFNrMU9KaUxGRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748006270),
('CghsGOrPhvLN2PurkUoQwaqBnFcyvqGm3wtlApTo', NULL, '195.26.225.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaEFSNnBSZDZ5RE5PeGRHc3pwTHIxeXFKYm02YXBpQ1FsOHpCN29DRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748394367),
('CgJjge4HaNUBC50ycKY3qBq7A9LLRyMvn5devIQk', NULL, '13.89.125.30', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSmozMHhndEtoQWZiMlRhcmdTNkhHU3I1dmtsajc3TDZlbmlYQWZMeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748303273),
('cjPd5MAesyEPfLRKUUmfpS73k4yywSfxsBTqNGHV', NULL, '18.212.232.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidGxCU01FSUNYcHZybWxyUVBCN1JuNDZWaEh1ZTdjMHJKOFdXTGVRdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748047741),
('cjw6F4VLHwc0CcR83f7MwctBrcNnxLdnBsxxg5n6', NULL, '198.199.79.218', 'Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZHFnRkJ6TjNrM2RBTGZ5SGNPTzcwdjBldlhJd21DWWN3d1pMTmplWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748158389),
('csYI6fL4eVhc6i4JqNCAKI7uGLxjQNXDEyW5J5s4', NULL, '165.227.146.26', 'Mozilla/5.0 (compatible; Odin; https://docs.getodin.com/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR2RzT1NWRmtaNk1sRFFZdWYwS0x1cXhIU3NkQTBaaUtDMEwza083NSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748203853),
('ct4GmrwPsY6HoBnmfqdjW208CGwW3Y6rtYCR3gLq', NULL, '155.94.172.112', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoickNPcFRvbXoxaWE0czllVWNJU1g0MVd5NVlkMk8yRkgwZHFiekxVbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748177797),
('CVqvIA0yr88kyuEdKB9BrLL5wLlsDE0BaBBSLSVn', NULL, '184.105.139.68', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic2R0S0VnU0RNYnV0WUZUUmh0Yzl2b2RwRVI1WGUwM01pRzM3dHBIZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748233556),
('cwauD4dCyD54BENUG3DKN6lNSy7e6lyqIbyfuvTi', NULL, '89.104.110.107', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicnlUQjY2cGZoaFAzOEdHU0lqN0swaHhQYUVKVHY1QUZyT3J6YVhRMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748240118),
('daBakLeQcOap0qDT7dexVcFCCFnvsUNK4pezXl4N', NULL, '59.52.226.146', 'Mozilla/5.0(WindowsNT10.0;Win64;x64)AppleWebKit/537.36(KHTML,likeGecko)Chrome/86.0.4240.111Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoienFENXZVbEo3TUQ0Nmh0OVY3bjlrMmNkZjFrUjRvN2pzVHNSUXo0ciI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748178150),
('dcVb5Sh1O1YImz6KhdygzIEsxvqdbWoS9eXz9RvG', NULL, '205.210.31.5', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTlkxVXNuVllrQlNrZjFDR0V2NUo4Y0xjRGJBbGFDWHR1bFdVeUJMdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748125391),
('ddqpG8WJuEBrJDPxYvPxueDSvk8CEWwvmPfJFboP', NULL, '52.91.253.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.51', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRUNzYnhXZUJWN3RISTladE5Xb3hRUGtscG9EOTdUajgzcVZGWjVDbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748106404),
('dggsTWCA1BnCrfaW1ams8Upq9T3PoojPaAu4gUo6', NULL, '78.153.140.179', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOG0zaGl6ZFlTMjM4eVJPTERVT2liUXdIS1o4a0VKbU1yQ291bEVOZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQvP3BocGluZm89LTEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748356810),
('DGmItecB54AXrhLuNBdJgalpppK1XN7LsdIUQ3qv', NULL, '149.56.150.13', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWk5XYzR4aFBLS21vaFREcTJwV2RCS3Y5OW1XcEhDOG1VclZhNEVjZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748140257),
('DkJY81am5JwaL3LZWKy2AGQwjCxbtVBw1OckkO9C', NULL, '167.94.146.55', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaEFqTFdNbVNES1NtcXZDZWVpNFNISDNMRklDOGJEeW1ocVVDTnVyYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748388437),
('dm5YJ5NOny2NuNSDb7tYBUjUko96D0uo4oyvMu53', NULL, '64.227.146.163', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibDVHeEJHSXhVdndLeEh3ekhaVVhkcW1CSDQzYUFtSE9oZmhFYmNVViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748300812),
('dmex8LnVrQ4tgnbiCc79xV0TlAK8stJ3MoqH80yj', NULL, '54.210.170.208', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWJwdjlhVTh4QWNseHpSaXp0blB3QjZiTk9QRUZhbnhROEljQ2FZRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748265294),
('dqJkuqzC49hS7bBMDXHrPObKEAu3F87IAclKuPV0', 3, '185.146.3.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSmlDTHpCWHlBbUtKME40a2pGNFA0b3JoWWdoZWoxV2tmYTlyWE42SyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTozO30=', 1748236191),
('DQO40ZE0QqREfWK81TVvQyxuOK5QCfTS7k5sWYfZ', NULL, '162.216.149.10', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYkVwUGZGWmN0S0U2NUhQVFlKNTdOZlZBYlB4SGhlVGNkWnpibmVzZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748409244),
('DQwGLkE41KkrFd0dQW6ln6EoHQ7GEsYPFXHYjSCN', NULL, '59.52.226.146', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieDZvS3NVM1FURDcya2JzNHd2NGpXa3JyTGhZS1pzYUJ3VG5lMWRxTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748178148),
('dv0Ar0w2ksWdYdFXgORD9P1j9BujICJHEy4gYZVi', NULL, '185.242.226.163', 'Python/3.7 aiohttp/3.8.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTTIwSDB2YU5WaGRRajVkN29pMjdNZTEyZnUza1NXN0FCdmMwY09wSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748381525),
('DZRAxxASqnvTgk6RNDhglWJBiN37Iw24hkb91cv8', NULL, '155.94.172.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWEoyNmpaQzZwaEJ5MmpHQWxtQjVDakNwajdKTWE1RmtsdVltbXVodyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748177789),
('E57oQmN8WojdGekRnxB5vsKNqplPrG1qozVTk5YO', NULL, '162.216.150.172', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWNnS2g1ZTlKcGo3NVRaTzZhWmI1R3lqdzllOVhHTGJtazZTWjJ3byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748146862),
('E9ZkanFj0Mk3woXimxWSty5HUzvvN8kw6vJfX7LF', NULL, '35.212.236.215', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko; compatible; BW/1.3; rb.gy/qyzae5) Chrome/124.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaHVMVldBMkJjRHI5Y1VuZzlsTUJPajliWGYwMVJoSVlhQnpXSE0wMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748127042),
('EcL77SvSBXsBAPHkCla1us1FDGUCZzGXNfTyIAlQ', NULL, '143.244.57.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaGZtYWV1anFTd280ZTBxMGl3dDg5bFpqcGh5S2kxeWZNU2Vva1pVbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748352924),
('eHW1owPZRWCdMZ2ZJvJ9Ce9Q4p4a3NCFUk2IMJ3m', NULL, '66.132.153.61', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY1JRV3BvNGZPTjZTMjVmdm9HM1lXdlZ2UjJhbEViRWF1UERIS09jRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748409305),
('ELt33N85dpnWZn63rlMAdTSjiA5fkDIxRSlIvz9s', NULL, '46.8.17.77', 'Python/3.11 aiohttp/3.11.11', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTlVLbXJuZFdONzg1cmhCc2VpMnptaWJTbFp4U21iNndvRjE5d2FMYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748016187),
('eXvlYqmE1bFLOrtUzD5Ien1I9rHrdsq9XdkvV1iG', NULL, '35.203.211.203', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOERGYkQ4S0RZVTFSRENoR1paMm45bUpyMUdsQ1VmYkhlMHZja29YZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748051527),
('f3BG6nYRQDvu9yXo9Fb3glncde8nzBgqcHBxozCM', NULL, '206.168.34.65', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZFF0TERPdUJLN1E0Z1A1NTNMdGNzd1VlSUM5bURERFhMQjFQUkdaMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748189623),
('F8aOuYSxKMo3MWErEl2yPEnD8neYrWNXNg4OMd2f', NULL, '20.168.122.83', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiME9IdENrelA2Ung5MmZVUEJobEl6Y0ZvcDJDRG9LOTIwQ3AxY3RJbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748173235),
('fGrBWILHbGTB9GNouHtqnlTIrexS3OrxjqibLuWI', NULL, '34.38.121.245', 'python-requests/2.32.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNTJoQ0l0SFRoM1lreGZXclF3YXQwdEVubXhKWXJkckltRHhBYWx4bCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748362832),
('Fj3WJPZHVm4eAO5VY10ECNkMg5FQ1sq4dRDZXwgr', NULL, '178.128.165.184', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaU5zTFNROVZ0Rng1NkFIcUdWYUFmQ0hiWFZXZ1JEMFFuTXpXYVZCTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748156786),
('fJbRigtgXsugOUxoxazJqzeSr5QTHRyt2PFynZRI', 2, '147.78.182.224', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Safari/605.1.15', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibmJMeGhhU0JhRDRCS2Vudklhc0ZCVjUzS1hCSlFSa2VXN1dhU204MiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO30=', 1748284811),
('Flg8kSqYjOy8Pdpf8olHvnUh4S7kiFkj31PxxJqo', NULL, '149.56.150.104', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibVBPUFVJZUtqUmVyalhJWnI4WDZMYXRxNU44NUVmWktlb0tVR2daaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748140281),
('fltZwLcgI70cWjrFJE88UTMOLXirvO0BPKTgfoI7', NULL, '13.89.124.211', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWlJjeWhRNDdKYlplQk9xVDhTVUNOV2M5V3hLNlMxdnh2YktjREpHWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748048137),
('Fx4eGHTaKXajBozFPeg5NRFm7FOOhn0Vm4WLLJAM', NULL, '213.171.2.30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS0Y2VU1FY0pjUEVxdGEwTENUZ2xiaG1La2tDd0Y0cHd5SUNuZ1dPTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748259164),
('FXDYkWUN9Xsj96C7HAJggPcf3WGI25RjfTLlh05t', NULL, '155.94.172.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibXVaVG9ZQkNOSWUzWU9IRmpIWkY0amJlQkZ5TFlsWXNZTGRmd01hVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748177790),
('G5Ee7Zugc9fp5A2kKnaITbwp8nvdHb2eQZMtKDch', NULL, '176.53.222.253', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMU5BTGMzRHhzN1c5eG4yZ2V6OE1kN1FXQk1wMU1qeml1OVFjSndmOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748209184),
('G9eO8U5mDXmKNcIdWr3CBFWgbcsj0XcJTzUXYY98', NULL, '80.76.49.124', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ3l0MzFOeU16UUZDNGl0SlJ1Skx6bDhnbTVvSURieW5lVUZQMTBhTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748040175),
('gBgr8uPWI7Ow05e7KaUqhEok0k68ESAz7JUWkE7y', NULL, '57.129.64.237', 'Mozilla/5.0 (compatible; ModatScanner/1.0; +https://modat.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ1VZT3B0ZUM2alltbGZpWGF5cVNjeEdXaFN1THp6bFl3UFRqYkd2TSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748166362),
('Gk1VrDLxYlqcoKtiiGph6z3hiOfLhHpXrgDQ2X5S', NULL, '34.168.224.252', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:129.0) Gecko/20100101 Firefox/129.0 Observatory/129.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1VUUkNWSnplTmZhRlU5cEN6RU51SkdEemg5N1hqZEUwWE4yVVZMayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748460298);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('gKpN5SYgbMjIiIMssBJnway41Eozhje4VL2LH8BI', NULL, '45.156.128.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQW42VGMydnZUcURvcllMWm5uejEyZ1FqOTZZc1F3VldIcGgySVdqeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748135215),
('GPcY296gzqizCwum0HG9osBddserC1xQhXrpOcxE', NULL, '209.97.186.240', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ2Q3UDIzWlF4SFp4cjRBbU1wRDhTR2VXbkhZSkdHN0NPNmxjekg2byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748332080),
('Gs69hlErMCZsVApnPybkdfSC2DK8eqRDYylzvveB', NULL, '167.94.145.99', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSGlWSUc1RHdzWVU3N3ZkQlhnOE14eGJqeWo5UlNzZXJKb2xHUFR4QSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748088862),
('h1kxuiMRd1HxbyLnrSWyuymU5jondFsi7htb0Gjt', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYWM1bFpxVEdENmR4R3VjcHA2UWsyaDVDNDhFajgzRU1UV1VxMjZSNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748462328),
('H8Wcy6WyvzSw1axuemQWPsy3i96qJqs9AcnG2wyQ', NULL, '155.94.172.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieUdZSUc5ZGY4NHBQbXVadUVyOE9xcWxhWFVQZHE5ODJqa243WTdEUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748177790),
('Ham2ld3m6BzsoveUJGyvsl8pzVLJV5vBZhUFJ0RS', NULL, '45.128.206.121', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) LoiLoNote/8.0.0 Version/17.4.1 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMnJzb3VMYkZBQlVFNFg2SUo2M05nNVdHa1Z4YkRFZVEzRW15TU1CeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748402134),
('HeCFRYqi5bHqWMvDdBBeQHtCCv21z163zwsuz42W', NULL, '45.131.155.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzZBVnJSZEdNNFcyT28yajFpdzA4b2dmSUFhUzQ3NE1ST3BqcTRYVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748455679),
('HFA2ShLL54jkUrjyi9kjytHyUFuim2FJBOYFY9WU', NULL, '176.59.73.120', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOUwzaEp3bkU4d0tmbHVPZVNVTlVITnpBSXJjMTFzRGRqMHluRXZZMiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNToiaHR0cHM6Ly9nb2xkc2hpbmV0cmFkZS5ydS9kYXNoYm9hcmQiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNToiaHR0cHM6Ly9nb2xkc2hpbmV0cmFkZS5ydS9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748365091),
('HHAs17aPWfmlavwmilMBrUeW77uVJBPwlbaZgVWd', NULL, '91.84.99.6', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTlFTUFlab3RDNUdIOUpCYUFKeEZEVEZYVk5aT0RmUnEzVVNoZDZmRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748282156),
('hJIimqy8MBFCaKvBDgaOR1PC4kZtNJ8pkg0wsTjP', NULL, '185.242.226.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZTNzOER5SFhFTmZ1VGh0bnlobkN3NkVrVGY3b1pHZWh6ZERtM1NGYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748153770),
('HngIFfWV69pSffvCLKCIw9BwECWRuC2BU7LSoZSs', NULL, '51.91.12.152', 'Mozilla/5.0 (compatible; DomainChecker/1.0)', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiR2FGOG1XakZ4SUM1Z0NwZk13Q1JmZTRuOUEyYm5XUmZYWWw3eHUxTSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748371911),
('hnzqTObQB5JsgQpdX6D3VjdO36Sl21DaymwsylE3', 1, '46.158.113.190', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiaHJYQUN5dlNNWjZhbTB3S0dmMzhGUzNzWDU2dG9mNmh0VVhDTTQ2TCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM1OiJodHRwczovL2dvbGRzaGluZXRyYWRlLnJ1L2Rhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1748085509),
('HXomqTJUxgD1CGNC1BNaVB4lWKvKmSJxQqSwiDSy', NULL, '185.242.226.163', 'Python/3.7 aiohttp/3.8.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSmRGSkxKS09nMmpGcE94UWhOc08xTWNTeXpoeEhKVXBoSXlUT2JxSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748094668),
('i7zE4teayWyErPhOfY0WiKgr9gryAn8EBeMHO2Yn', NULL, '45.79.120.183', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQXowTEllcUptMlFkVksxT1l4Um01SU1oMWVHendXVENKd2Y2UTJpNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748446461),
('ieIKbjx91Vc40ZF0ytGUpiEVP4TjqQPqYj09siJE', NULL, '78.153.140.177', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.2; Trident/5.0)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibE1VeXhXS3JLZGhLRnBLdzI1UmdtOUNOTnhHaE9VcFEyaERIMEZvTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQvP3BocGluZm89LTEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748427552),
('iinRsiTrA89dhdg0vxzgiwmzwM0UDcXx2D8kiIKQ', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN0NTeTN5TlRCTE1LVFNjZmVIRzNNVklISXhMVWRMb3NqbkNlbDZMSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748093572),
('ipGEl0jUsUWCk1mrYhaT6eALbfzxrhGAzbtm3EXh', NULL, '89.104.111.235', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWm44U1gzaVpoWUJLUGh0UkxCWmRWTWRDZHZCSU5WYmlyZVdhdjBYRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748326798),
('iQoRyDHTspHutO26xmaTmNkmWQd9hikD7vPCQCQe', NULL, '213.171.2.30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicFQ5djcwaFo3QTZiUkxMOVRTTFd1RXdmdU1BbjB2OHdwaFJnM1BnSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748345951),
('itaPqKy2xbalhc8SeO2s0TUuP0cLJWZAXC1W69yh', NULL, '31.8.123.233', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 Avast/131.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmxBa2FUdU1uWmNDaDFJdjAxSGxPT2c2UlNJeUppSVQ5UDlXemYzVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748059062),
('IUNQe2aKh7HrDWrWiQ9KYdLMfMOzkDGqEqz97EX9', NULL, '199.45.155.98', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWjFlMFNJQXRVSEtwekNwTE9oS0VCZ01NcXM1eVJ6WW9TRUJQcDFxYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748221766),
('ivHtSFxETFBQNUYC7vdwJs8jJnfTCyHmtdhqm68v', NULL, '184.105.139.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 OPR/94.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibWZseGFLNEZLT1UxT2ZhRVR5Q1FRclBHYTlJaTlDVE9oTXgyaWM4ZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748331415),
('JaegzI0s3jOZKivzwSWUQzAByTVY8YbUW7o1cGjm', NULL, '35.187.71.104', 'python-requests/2.32.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMDF2N2k5eE9abzhBeUQxbUdrODZ5NzlKUzhyWVJ0eTQ5RHpNdFlwdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748191817),
('jDwZSPkYzuTZvF9Yntc1z5cXmKXqGtSz4oUcretA', NULL, '45.156.128.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSTA0TkNER21BazNNTU4wYnRzNHhkTVZpZThVMTZLRWRvczhyMVVSaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748039974),
('JraSlvLvGarktnkxcH8M7Cv1vHLPgMQBOsi3Ywxj', NULL, '195.26.225.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibnhzR3Fpd094bFRXaWtkRmFQSE9Dbkh4QWtPTkFUOXNuUmwya0ticSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748318217),
('JwHPLkvjDKMA7XKXImHI0u1RjYj7ZacgD84gSgkK', NULL, '106.75.13.178', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNm5IR1VsSjhUV25BWW5BaUxZaVJPN2J5bUNCTFBxcVA4S1ZCVUJPUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748122543),
('jYvU6yQ37LajaQAmdonC42hjz7yHf5oLe84OuWQZ', NULL, '176.59.73.120', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ3lkMnk4U1RXWUo4Q2Q4OXB2ZHZPZEdFSUZad0I3MXF1RDdZZ1p6ZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748365091),
('k7YrPKmqqXSVRNdTAAPr9wwOsJGOFezFawY5dzon', NULL, '170.9.239.89', 'Mozilla/5.0 (compatible; MSIE 10.0; AOL 9.7; AOLBuild 4343.1028; Windows NT 6.1; WOW64; Trident/7.0)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMzR0ZGJRaWFYTHRjR25pNEVrNzQzdXZ1YzdlSDI1TjRWd3J4TW8yNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748342075),
('kmJgQdjURqFdRvISddNgK2xaFwO0GZtQiX7FSkBJ', NULL, '77.222.61.15', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN3ZJUkdvak5XVmYwWEdWaDlacDZhcTZNTUVmb1dZUXVqeW1jcFQ5byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748159844),
('KOMzvvlzxnSC1SUMPQ159UJFG7vcqvoWZ8uCcovb', NULL, '191.101.145.244', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNnlYdTh2UHY2UzhwNVZ5VkFjV3Q1ZklZa1B4RlhGZzk5eDNsR2N4RiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748015796),
('kRsprfoJ4AklqtlOzld349j9fXqDcX43xaap4AcN', NULL, '45.156.128.119', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0NsZWZ6T3VFbExpQXdEeDlxYW5MbVBoM2JPZk90YnNKSHl0Q0RQZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748134905),
('kuofRhx3OIZEyULrwzVIkRIfZyWg8dgBeU4xeMYm', NULL, '205.169.39.124', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOVhtdU84YXdIcHBoRGJLODVJUnNUZTJqeWcxZk9tRmo3NFZsRkFxdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748110635),
('KVlqVWN1mhHozlHGD1o5B66VpBuO9RqioMFDMx7B', NULL, '213.199.47.87', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2x4a05ja2l1SUY3REFGNzBxU2xSb3lndGZaSUtDSXp1cDB2cXFPdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748011805),
('KyH0gMaSNiHEcEVqntbvHXAE6DEPcCIRmKlndCuL', NULL, '213.171.2.30', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMVZEbENkZTVVSkhkc2Jxb3JwMFVDbGh2ZzRlbXh1RnBoYUh6dG5qUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748256999),
('l1EOwoVhnG1H8I6tBn23KMZ07lEbpZqM83g2qT2W', NULL, '34.205.23.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSlBtODhNZFZXRUw3ZTJhWnZJcGlsRFdlUVJSeWszZ0VrcmFRbGlaciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748126656),
('l21geevqQZ63Z8Og61LjWN2axcuus3zHwzfE4iWA', NULL, '165.154.172.88', 'curl/7.29.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSUViSUVTSnRzVFdmWXVHY1hnaHl3NENDT1VxNHdxUlVQdW5VVVVQWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748139849),
('l5mWsKJgJdkTto909ug1JaeKaUvOmn6M48nNQvcs', NULL, '45.156.128.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieXZjOEp5b0s4cmFublQ5cGw0N2g2WFRjTm1aVWNUV2tRQlhkajdkdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748134766),
('L9drPlPrjbZGQgJL3WhNn0WmT4LNAM4BYFl1sgMp', NULL, '185.12.124.78', 'Mozilla/5.0 (compatible; BackupLand/1.0; https://go.backupland.com/; Domain check for viruses;)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZEs1bXBZNUxkYXdZZkxoVWZJN1Q1YzFJdnpzN0NoZEtGWURFRUlFVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748379324),
('Le7GzNzYGk0kSr71qNQRx9aPtguXrGN7B635m44Q', 1, '217.145.224.153', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQkE5UFVjeHVnellCb0c1Z1hCYTZsWm0zZzJTMDFpenNaQTVqWHA5aCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUvb2ZmZXJzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1748035034),
('ln4C2o8tPUxYEA02HVZDExg0oREcaInBagntmWtI', NULL, '198.235.24.173', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicG9aS0VjcW1pcHppNkU3SDY0ZzhSYnc4Rlo1TTVVWkVGRmoybHdTdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748059750),
('lNtc7Tlwp7ez2eYzsEzhZ7Za3l7qv5hT93bGh6RE', NULL, '36.112.213.21', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRlpkejZ6aTRmTFdsek00MVd5NWZITnEyV0k0MzJVdDQyR25kQ2Z6biI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748457353),
('LrlKJnlhHXepN30L9o0BR0Ocd4E5Ut6uF1ABLDKc', NULL, '54.71.187.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:136.0) Gecko/20100101 Firefox/136.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT2l1RnpzWFd2NjBjcjVYT3Fmd0N5OWtCcTg5UEZSb2FxZzk4ZFhaWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748106405),
('lVB0K76zPonwcuX26Z6jDokrtARzktCN2JByAAew', NULL, '64.62.197.102', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.2 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibWVBU2k5MncwTHVrdjBEZ1ZmYTBkNEx0N3ZSb1JOcEpwZm9GU0dqMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748134044),
('LX5GcuZfV4fFUFCoCJ9cxR5ZLimC8vWawzqbCvKJ', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieGhSMHVaMVk0a2o5RWc2YTlyYVdlSlBvTG9qY2RRenJzdjl1RzI5dCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748175002),
('mFV5Rzy6u5nreKMrXglKVp7rzt7SiZjAqBb9G7fn', NULL, '149.56.150.13', 'Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT0MzbjdPVzFmbVd4RU9Vc0w4eTFyNFIySVBvQXhOenZCTDZHTVloSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748140258),
('Mm5fE3pUf8l5T2TGhXfLSPvCEqWeINqdZgtRyNQd', NULL, '80.85.246.214', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid1lNYkJkQ3gyU2hlc3VHYlRkaXVBM2JGSFFTQTZHWXB5ckp5TlNCWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748047003),
('mOJSprwgfkTSuGpFPvxWEe6Hh34U8ANG2CCn5hP5', NULL, '115.231.78.11', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibTU2T2ZaR1JZOVM5Y05FbUZGeG92MTh5cDJsVUMwcW4wN0tmcWNWVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748411197),
('mommo6dNe0QPw7fq88wfsHYLvmrZzYqGC6Hwjmys', NULL, '185.247.137.80', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRzNWSE9OOWJ3OWpXTnRBSkpRSGpEOUFyVUZSYklnRTN3TWVVckZPQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748235144),
('MpFDMrdfKLPzsB8gKvy7cP1bxAxd2bR9fceU2Tf3', NULL, '43.143.60.88', 'Mozilla/5.0 (Linux; Android 10; LIO-AN00 Build/HUAWEILIO-AN00; wv) MicroMessenger Weixin QQ AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/78.0.3904.62 XWEB/2692 MMWEBSDK/200901 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT2tBbUdKSUtxVlUyb3VoWHpVdTRNdXViNlFjbzIxRjdZSU8xSEU1QiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748345942),
('mPP91PtBQN6Arw17SqG1rKrsUqXFEdwEDj6jlOcu', NULL, '147.185.133.192', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY3Q3ZmZXZk01bktYQXg3ckV6Q3pLbTJIcVJ2aVg5RGNYcEhJcHJtMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748303935),
('MV9Fzw2HLKG0hreh4YVyy0EPEaXdbkoOBuHlJRtX', NULL, '45.156.128.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUlRLSlNnMFV1eFhhbkpaaVBRcnJsd3RXT3BoZ2Rmaks3WXp0MHR6QyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748134766),
('mvun9VTBtC6kVtX6jJpHOs0oLxJ6de5kcd485sT3', NULL, '34.116.39.104', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15 AppEngine-Google; (+http://code.google.com/appengine; appid: s~virustotalcloud)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTEpTV21QSzdTWXVPeng3RXpkM1FtYlAxQ0dSSlJJUGk5SzYxa254TCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748106404),
('mVXPnoJ5doVK6sQWHSMb4BwkQiFanuQUfrmrl3WY', NULL, '184.105.139.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 OPR/94.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibUF4Q0tQWTFCamppVlNBbTVBYmFNaDlQaVFLdHhlQjBTdTBSTnY1ZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748332051),
('N2cKJOINs46Z2TKSOOSC4Zh6o0TNVPhDlhvikmlS', NULL, '34.168.224.252', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:129.0) Gecko/20100101 Firefox/129.0 Observatory/129.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVzNzTkltdUxDelpsZ1M3NW5pY2hJZWNWNUNOSUNHeWt5bUFPSDNYZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748460298),
('n4MN425zszLK0A4hOQBRZpTFdApavOBOe4s3Jm4d', NULL, '77.75.156.201', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 YaBrowser/25.2.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaFBycGZjZUZFbXBRelB6alJTZFJkWFRRM2Z4Y3UzandWQWRka000SCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748421967),
('NbaIsjYpdnJZGePmujkkFoWNnGo5K5e2qEyAT9cM', NULL, '89.110.109.74', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidEZKTHRjT2QxRU41eXNSZTMyTkNya3hlZHVDa040bG5EMnFwcGhsUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748197265),
('nIjmQVr66FTquzF0cHtEBTRoTkxgazpSR55QaIqH', NULL, '68.183.77.146', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUjI4Y3pQVWxSVzU4OFVCc21ZdTVzT1kxTWl3dTBsOEdTNVRXQWpabSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748203196),
('NiSMxogBfNfk3Eo6c6C1p6d0AmhK1kCE7xunh8cO', NULL, '176.59.73.120', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQXIzaFZRcldtYmZHRXBORk5tdEIzUjZsUmtWMEVQNWVzeGVFU01wbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748365886),
('nJ14VLyyyLSAmdVvDcafcNdPNmoPc0EcaOJGxOsj', NULL, '2.57.122.234', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:135.0) Gecko/20100101 Firefox/135.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUxoVjZZNlBOaUxaY0dxcDdnMm9QZm1BQ1JLbGZEbDlSRXNqRU8ybSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748356796),
('nNGqq2ZFojAyMG8OOxZFAYKgGEcZ9WQxl4fDlfy9', NULL, '8.209.96.179', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaDRBWkZYWVlyelp1eHZjckp5M0g5b1ByT2gzTGQweUp0MTBqRThLUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQvP25hbWU9ZXhhbXBsZS5jb20mdHlwZT1BIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748400499),
('NOJqPNXykRvqaEP738VruhiOYGAU498Yhzi2RhSO', NULL, '152.32.208.106', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibm1JVUlRVUdXYVlXTlFRRHZYNWNvY213bW9rYnUyNUdqRGlUQzVjbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748021174),
('nOZ39szxaCObRgTjHJTe7kt9AQDIGKWG6e93nppa', NULL, '195.26.225.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid0o3UWg4MThka0lVOTUwNTBzNEwwY0NhTm5BYkxDaEgzQ3BMRWR3eiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748000988),
('NPHE6vkmCNlwfsbebAHrSpQyhb5KpjCyDk3mFXFB', NULL, '45.140.53.216', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWnBHVHBtNjNYZktUMDVRNk9CV1B3ckN4NHcxTTJFcTBLaU9ySndoUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748052151),
('NROOBuCtbek2Pm61JEnf4BkdTOKcEEnOmjdC9Uyk', NULL, '46.4.38.254', 'Mozilla/5.0 (compatible; 2IP/1.0; +https://2ip.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaWZqOW9jUml4Z0xDWEFoWTdzZXFTaEdMUVpGU3d5RlNRdEVlODZiOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748106411),
('NTRz0Yjl6MUfoNieBbblvQpxWtckWx64eZwCwVy6', NULL, '172.253.254.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY3JRc0c0MjlOeHlMUnVicndocjhRUldHMTNOT1R0dFhGelpWWFhpYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748204311),
('o2laYGIfiJfOyNP9DgrM8EB4tH3DntS9WYCqhd1S', NULL, '198.199.89.32', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicnJ2STF1THJBNzJCemFvUHJYcXZxUVpLR1ViS0lYQzBQcDc4QkhDNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748399809),
('o8Y3BYOaHR4t9IJQyYHa5wTXws6n4osBsU1V3DYw', NULL, '213.199.47.87', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ3NERUo5dnhHeXppTVFCd0kyaWQ0aHVTaFZOUEpIQnVGRE5leENISiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748120050),
('oFTWkx6OVL0Y7oOw8txHGsBXq94RUN8dY2ycL8CN', NULL, '196.251.85.111', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYVVXTGNPaFF5UUx6SU90bDFlT2Q5SWpKRHJJQmNEQ1dPYWlVY2tObCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748212396),
('OHnpcPrBOegVUpBAUKdJSaCLJB2oZ5Sg23yZb2Tq', NULL, '64.225.30.96', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM1NBcEF2N0hLRndiTkpUQ05BSFhjTVJLUUdvNnVEbWtjTnNnYjZBZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748161051),
('oVbNRAjC0EDEkaIuPJSrL5fXYmPKvepo6E2AApMg', NULL, '130.89.144.169', 'OI-Crawler/Nutch (https://openintel.nl/webcrawl/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY2luMGVldHFyc3hJSnJEMks0MlI0NWpjcWRnb3RRVFprSXBRZFZ4WCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748377792),
('OVXw9HqY8C9oflfKMRk8bieCWmTSUJCyrGzUXzh6', NULL, '104.234.115.157', '\'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)\'', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOUhodHBudjMyZ2JLSUZwRnZ1SjdQUWhtNGpQeXVZcllFaXhybHU2NiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748425627),
('OwnwdMHO409lLtQ1qe2e3spjYT9N4dWYfseSBslQ', NULL, '45.82.78.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36 Edg/113.0.1774.57', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNDZjbm55Q1VWZHFkOE9EVFVWWVltUjQ5dDE4OTh4WGRURUVaQnE2dSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748416211),
('PcWzTtb1HV7lkEPbE0pu4Yt3L62kTbC5EtLhz8mB', NULL, '71.6.232.28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1pCdHpIYTEwZnRoV0lNVDlOTEdKSmozVEl5WHliWWtIdjZINmdlYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748270584),
('PekxVSBNPqQzKiVzSWGw4wCLfDXuSL19XEAlnbWn', NULL, '89.104.111.10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ0ZlM2JUTUFmU0lrVTB6a3VVU3BDVDNvOFdxdFA2bWx2OVJvYjlrdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748414485),
('PerSmvH4ae3SwUM9ZdiubyXfMvKe42L7FJI9EKza', NULL, '66.132.153.62', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYWVKUlUzNVo2bnl2WVRLaHp0QU1YRENFYWszUHJob01SMXJsYTdVZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748119668),
('pgCkzh46TSHZVW7auEbqu7zAnL8qOsFoHSqcgT5f', NULL, '3.142.92.155', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.51', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOXl6czVxZFJhanBQWWVnTGx4UkxFYU9tMmVEVGFuNDhjSEJNalZudCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748106404),
('pHDkkMOwKfxYJlUnZ8hWvfCqaI9AAOrXFAnaaRez', NULL, '45.90.60.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTVBhWUhvU3pMYXpoZkpsQVhYRW5FV1FhT1NHV0h3MkxJREFtendUWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748362081),
('PPVsBbHiF974qEkol5uuBkBNlnRuduyLuBtGO7cl', NULL, '213.171.2.30', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ2hHSlQ1aDJmTlBtaE9lNzBDSjF4dXU1UWdWVGNUSzFkb1RUNlBEeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748258399),
('pQLyOeHT6tXF1Sy788EawHqZoDMW9C49QVMR2n73', NULL, '45.156.130.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRE5GdXdjaklVdVBtS2tkUnFuVHFpSXJHOWo4SkZ6YnJ5SUo3ZG1WTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748011970),
('PrJRHwRB2FVhhuKObWx8SgvuiAr3DlHkZw3FEQMH', NULL, '205.210.31.15', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiME41T1duNXFTRmV0OHZRemY4dm9GUEVzWXRSc3U5UXNDampjYm1wNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748398928),
('PRNaPRwQGLw39Q4UoPGGzCkszqTKcbyjKjjuqbo1', NULL, '205.210.31.152', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRWdYOVUzNVZGZDlDSmZTSEtJRnJpb1FzRUM0eDFmb0NRNVBkWHVDRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748048471),
('prqo58uNRejeumEdD7sX8P8HZV3urKOQGzobuK2h', NULL, '155.94.172.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZXFXbWNyVUZWWWpRRkVUU2pPbFVoRnRVeWNna2dMRjlDMjNGOVh4ZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUvcmVnaXN0ZXIiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748177790),
('pRuGhIIeWfwh4K3M2RlCoJzGGDCzDwlsDHNBhEyG', NULL, '170.9.239.89', 'Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; ASJB; rv:11.0) like Gecko', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ0x2OG16QTdWc0NOOEhlMkwyalpOY3VrVldtekY5MUI5ck0wSDhPZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748279804),
('PTvsdzMakOu4VmR7FjgVjmz4BqXXGc7xeopIIlXv', NULL, '165.154.36.91', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVTN5V2FpZ2t4bUhpN0tGWTl4eVZpMHJ2WlljOG5CdG5ZNEJOSFBkbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748177671),
('pVe9DCsl4UPmYFwZ9qmL1CsAqKVqh5WWKX3gLuzu', NULL, '191.101.61.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWEp1OEREcHF2VW1nSkNJWHVZUUs0R3FEazhhRW9oUkVQVHhLazVMZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748110433),
('PyEtxrZvkV6i2Qz48gGoxYXlgNzcaP2icmb9xooK', NULL, '159.203.44.105', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZlhpTXhiNDFHVHI3TTVBVzBGMU43NGprT0FXTlpsY1BTZHk1d3JKbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748170531),
('pZ0cFq7XxL8UgZ4UslrHSHfUMWGh4qUjRXTepEHh', NULL, '89.104.100.137', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibmhaSHVmbUt1ajRWTVBJc05qSFFTZmY1RElnRTJzeExmRURTdXRDTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748154277),
('q43UFPZunz1k6qJ2TGSyPaIDhtE2wFnPJMoqz1Vl', NULL, '176.53.216.77', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidTRNZko5cmtaaWdCSUJvVnVIZ1FJVEU4WlUwcGF0cGtKZTVZcFBsUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748099067),
('QatDKYblWUdbTqE5nZ49azWFyaMvaqrKh9Lgf7sy', NULL, '34.76.248.25', 'python-requests/2.32.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTmlGVWpnR3VXbE9ZNlhYSlpJcUdRUE5zTVJ6QnBlSHhuRERWVDJlZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748126493),
('qcmLjDRDX0s91IPnbG84AknacQGf6wbtL68dBL4i', NULL, '66.240.236.109', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1VLYll5UjBEZXdldUhoVTdNVmhFNHp4Y3VQV1M4eUdUcUJGanl2MCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748372575),
('QFx0f6oapx2zP9kxQEqjsT2Du2FMw9P5Uit7mHFa', 1, '213.171.2.30', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUzliRmNyWVNkYzd4NldPemVKN1E3U2JuT3N0MjRSVUpoa3JTRm9uaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1748256995),
('qkLxfhAaV3XTznWst76udFaCd0VMjWBsaGSri8av', NULL, '115.231.78.11', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.2623.112 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQk1CamZsRjlYdzdLazRmZjlDZnZ4aHI5dG1KWWVTTzJQZTF5UWVYaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748173467),
('QQOZXPhwzuzuOkFWBm6VK1B8x3i1THiZTeW93nli', NULL, '5.39.216.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNllTMTFSNXBHNVdEOTVQdm9IM2dLNDJQZTE4cHlzUXVtZWt2ZjRUOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748083837),
('Qsd2ncYbHIsQXeugsXRkAhTlEeVacfzCcI3XP5lM', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYnhIZHRaYzMyeVRCNHJtMGxjaXlCSWM3a3NDVFFuczFaOUd3ZkZJRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748339127),
('RatzDvmtyjLJQQH2sIx8F8MznZg4MOXuzi9MZfam', NULL, '18.233.154.166', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNzFJMGgxbUZlU0RvYWZaVWltMG5scVdXSXVhdVdUTW5QRXB6eUlYMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748329784),
('RcobRyE6ZrD1BzNDyxWfliiCuZnF1Q70D1FR9P1P', NULL, '176.53.223.128', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkhSR21oRkUyV1o2UktXdTZXbE9OYlAzcEI0S2RsS3FjajNtSm5rZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748067315),
('re0UvAJefRXOIoY4bvIBdVsak2un6lXQ0PmX2Vfq', NULL, '18.233.154.166', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaTdQUmFUdXpyR3JMb3FlUENvZER6eW1OQ0ExUzVjb3ZSZG9Cd1pGYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748400469),
('RJbFfDHMHVuwgc40M0ImDVIarvfpjE3Yrc9SFjJQ', NULL, '164.92.125.253', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ0h3dnlxTGt1Z3hNQzRlNWRDM0FnS3NLWTNEeTZWc1Mya0QxeUhzRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748334441),
('rKKIO5vK2gCeohSGa1WrR4mGMvWr0eNewKtAIHAj', NULL, '205.169.39.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.79 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaXJzSjZieHhHV05EOWd3MDk5RWZRWnMxRGxQUWQ1RGNiRjRWR1lQSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748110638),
('rl7Z2tLoBndyA2GHtqPJS4lmrWsBNdSXBLSCf1lv', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieW9KaTg4RGRkWjcyaENkdzFEbzRSaXpUT25oakNzdGJESmN4SDg3eiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748011679),
('RO92c5wUWoBb8AAOIi3oa1ewVsv2eWxbZZWqvftt', NULL, '77.90.153.48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/113.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVlBGRjRGcFhjclllQUhtQ2VJcktJbzNiWU81SEI3WFNnUnlINktOZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748287030),
('RpxWu3ydqx9FLgUQUiit7yGcVJgq8ZEMUy98ZFrE', NULL, '34.116.39.103', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15 AppEngine-Google; (+http://code.google.com/appengine; appid: s~virustotalcloud)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWml5TXdhcWVsQ0N3UGJlQUFtcTBzdFpXbGR4cW9rYlZvUW80aDR2ZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748106414),
('Rq95udtOTQnFbem45aIUYK9wZjF9KuDNpWIztucC', NULL, '185.12.124.78', 'Mozilla/5.0 (compatible; BackupLand/1.0; https://go.backupland.com/; Domain check for viruses;)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieWpHdmFqTEFBVnBVNXFxbjdOZE1GOGJSNW5UcGU0UGFXeWNuUjNxNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748022828),
('rsNWBly1nC2vUuOrLkORVKYGyU6NHTzIdfNuvu30', 1, '5.138.184.139', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaUFabVFWRHZTaXlGaHl6Rjlnc3VZNTAwYmxsWGR1d0dRSFBJbGlZRiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1748461977),
('S6VSEBT3eZIp4dF4U68bYI63BMEiYy75Yi0ELlk5', NULL, '146.70.194.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMk9qRlUxWGVNUzllZXhoMHVJdGpxd0dNdXVkcnRJZms5WFRZOHIxYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748231447),
('S78DTLTFVFudkuhtS1BNqMGQ3i1DkqnIpDhgDkr6', NULL, '212.34.154.131', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUkpTS0Q5dFQwRUUwcTFmTVdpT1F2NThiaE82MW1vbTRlQ3JEV0JqeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748109786),
('SJM42yeoLhtGUg9OuuOTtdUwJObKtEfiH5gFndHi', NULL, '185.226.197.30', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia1RHQ3VEQ2IzNmFzTEttR0dkTEZLa3Rkdkl5WGpNbXJMVmpLVHpIOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748124743),
('sMEf6twfcLYGs6Qt46jndR1a98KbRmkTZPnZM4LQ', NULL, '185.242.226.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/95.0.4638.69 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidFM1a3JqdXhDUVVDckNMYkFib096dm9lb29lNWM0dGY3eUxUUXBtRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748153770),
('Sn9uf0c75EonuW3aET7WzKr3QR4evvSVTliAXSGW', NULL, '78.153.140.151', 'Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8.1b1) Gecko/20060710 Firefox/2.0b1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM296dzI4MnRmWGt5QUFzUnZoSVVoMWJCclZXVFprUFZUUTEzMzgzbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQvP3BocGluZm89LTEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748213337),
('SnHluXqvrK0FdsABgFb5mvTqml1DwRPNHQ3NQz4m', NULL, '185.247.137.249', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR3FtbXFZTEdDdXo1WFFOQ0JCMWM0SDJncE5jem8zWnRKNGFJVDR1WCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748008313),
('sPFlYBOYHGwRfKveji50qoA1PizyeWgdT9Mw58Ew', NULL, '8.209.96.179', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibFRXUzRmQTAxWDRWcjZQckw1SThuaklSNDNRNUo2VHFSTVpIcWxQeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQvP2Rucz05X0lCQUFBQkFBQUFBQUFBQjJWNFlXMXdiR1VEWTI5dEFBQUJBQUUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748400499),
('sV4fASYQYVF9m6WppcQYcKLilZBI3NDuJykovzTz', NULL, '46.8.156.158', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicVhHeW1BbThkaDlsV0s2R1dnUlFCOUkydVZsUGx4TGxiYXdxY3RoUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748162293),
('SVNklz9KRBHkJmS63nwGY4c7n68WsvsERSYoD32P', NULL, '103.203.59.1', 'HTTP Banner Detection (https://security.ipip.net)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMnZzZ251dTV2bWhKWEFneWVPRjFjU2xHQ2d4WmljeVpVNkRuYWx0WiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748355636),
('T38uGtSKL9rORKxz6kYxequPigBrWX8vTfeTAy39', NULL, '212.109.195.88', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOW9iSHBJVjBRTW1NWmFkVkRIV21tbGRxdVB3cWJaVzJpNWw5SFdmOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748181371),
('t98fSRBw9Ug3tI02nTpqtsvDzMnj5sRNFfqDWyiN', NULL, '185.242.226.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWs1YWlLUHdmWDcyOGxtczhEWEtNWWJkd3B6QTFRSW5KcjNWNXdRaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748150730);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('TBqqfGhOWYYdG5jVuQS0r2YDmlLbx5fBuDGMMaeR', NULL, '149.154.161.233', 'TelegramBot (like TwitterBot)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNVp6SW9CZTN2Qm9xcWpTNktaYzlwcVB1VHd4OVBhNU1UbkVIVXFuMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748079859),
('tBTBLoHoGq3MMOYgvp4rpIheC4Wk5RitzIRZEGHn', NULL, '45.134.140.233', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkU0WUNZeUxmeW10dGVHVkg2NzdIeTNCUHBmQmUyMnhLYW1KdnJ5dSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748136524),
('tBu0IpUhlFB9trj4b5gSsMqf3k2rqbp0eHMLp5c5', NULL, '34.123.170.104', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/125.0.6422.60 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidmZ0aG5LTTFlVmVsVXMycGJ4d09oeGdsdlpiZVJpemplbmQ2c2FRcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748110070),
('tdGjqE96o8bXqCC8D9j9uz0oB7zDINXP8PT1HCDC', NULL, '185.12.124.78', 'Mozilla/5.0 (compatible; BackupLand/1.0; https://go.backupland.com/; Domain check for viruses;)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV2IzeEFhUnUwb0VsejFWZVFLanRMOHZRcGU4aVZlRFJqYzB2NXI3UiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748260462),
('tGgXNWqZLuSDqMSrooHwcwFKhUO0k5LO3wHoKlHz', 1, '213.171.2.30', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicWI3ZXJYT0hRdWg2NzZBNnJDSzYwcmtzTTZkWjVabU50aFI4MVplOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1748345729),
('THi7i6SYgsAECrdr6ZQHIFljX7cI139gE7iCZzMd', NULL, '176.59.79.93', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY3V0emNRQlF4ZUJKRUFqbW9sM2tBUDNyRmJ4TEluVEF5eHJrQWZIdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748158602),
('TPrwZeTPhoz6fJGCaQKAbYwA4LuhoSdmot5you3v', NULL, '91.84.104.205', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRGtlN0tNdXhaYmlaSm9FYmp6bWlPTnUxZnB2dFBiYllaWjRnOXkzYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748125803),
('TTFJHYtg6scxXIGFr59WkhrdAcrRD2Avcfmq7tJe', NULL, '64.62.156.110', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.41', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMEpWZ01zU2RaV05JN0FsRkpHRTNzS3lXU1pRTERMSlJ0UnI4U2tOMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748048389),
('TvgUoqOY7IzZtrbItpTvPJte1Tw9DRID8IM4FU7R', NULL, '34.210.72.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicklOdmIyZlN5cjJMek85RnY0YWRNakFHNUVXbFNKZEp3aU8yNmxIbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748127167),
('tYBFgmNZBfrjBSlguILKz36pOURODvqJewUDd6EP', NULL, '68.183.77.146', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNVljd0Q0bDB4cEdTTTA0QUxhWjhwcjBRd1BCNlVGSXZCbnNkb1RzbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748203195),
('tzbjCAruO5Bl1dpwpkCHIE0SoAKRCqreAgwBVs3B', NULL, '192.155.90.220', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidmlYcEt3VGJCdjBzOXF6bHowRklPV1l6NlB4Nk4zTHlDQlFubEN2eSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748102038),
('u5g9mzjc7XdLfXj4CV5TAFY7qnklAUHrqvz2IqlX', NULL, '77.75.157.46', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/131.0.6778.33 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMzM4T0FxN1VFdWhNckpWc29zVlRvYkVta00zd3FtU3k5TURzcWxSWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748357754),
('uBIG2kgzQZP3yuoTjSTU9lOQWtUT7j4YfopKiXfB', NULL, '84.252.147.239', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:51.0) Gecko/20100101 Firefox/51.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT004TDhkdE5BelhoOFFpTzFVQk1GVXJaaEMxaVlXUTFmT2ZvbTR4UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748258249),
('UocOdM4VesHxo9blZz9Ut4EbMWsble12uvsbhbJk', NULL, '3.137.73.221', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1RJYTNLYVkzbk5kcklLeEhBU2hEWGQ5UEZtVkRvOTAyWkFHcndTcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748233924),
('uPHP0JrPDikSauSrDQJksaciHi5W1Bq0ha2Tk2xK', NULL, '155.94.172.112', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMlZEWm94cU1Cem41VjFMM0Nzd1VKU0NzbzJHOEtVdUxIcHh5ZlVMQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748177781),
('USIk2to2SpbLWvV9XtPSvWNOX6cMfK8wtOnAw9wg', NULL, '34.210.72.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWTk3b1FaSURpVlIwZWRxcU5SZXUyWlZLYXhDdml6S2dhWGlFVzUzaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748127165),
('Vd21oxjdbvLgDvhnN6CnKU5nGtIKhqGtAlR8hM5f', NULL, '68.183.77.146', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWXBhTnZYV0k2QmUyVDBQVlNIWGtwMUZBSWFCek9UV1BLTEV2RGJzbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748203196),
('VfiGo6h2j0d0pCg0PGAciOqh5jDhN2Q4HGoYJ91e', NULL, '185.180.140.107', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0hIZFg3aU9PYTBXWkxMOUw2Q1NvNmE3NEhLa09CenRJWkxPNUJ1UiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748441905),
('VJeFCXZyhwNt7WoVmm04mG0Vn7ByuzslexgW53Nb', NULL, '139.99.241.181', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS2RVUG9vR3dUaUU3VnVvZWo5dndtekJDSzU3VFdzRDM5V1ZHT1dpdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748250732),
('VkTE26M2K2Gx6IIfxIw7Mx6ukiGC7KZI36Kn0V0D', NULL, '34.116.39.102', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15 AppEngine-Google; (+http://code.google.com/appengine; appid: s~virustotalcloud)', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNmdVdmNqWFg5dm9aY3o3dTFEM1RHalBRM0NSZHJaWnVhbjM3MEFrZiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748106404),
('VKxvkTIDIHctNTZ74hx8qpTgYUuzhHfnIMf55R81', NULL, '198.235.24.252', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSlJCY2E5U0t0M1FJakRJcEdpeDJjd3RXSXpja1Bsd0FxVzAyejcwRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748316962),
('VxDFaXMe8iQL82nyPvQmb67cZSp984rZtk70pWDb', NULL, '84.252.147.239', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:51.0) Gecko/20100101 Firefox/51.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic3VUdlh5c01sODZYdFh1Q1VwMVZPaWdpQ041akp5eWhhNEZ0aHJJeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748258248),
('W03SM8ijWEXvoYUuUg1QhGM6cjqX0WRqQ12tfj3x', NULL, '85.204.70.94', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieUMwamNEY3hOUmZaTTBqc1M3YXdHYjMwaDR0UUcycXA0RXNMWkFZVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748393232),
('w5TPfAhefGOVlWDaOKlKtzUIUsMeJRMwytE40lMu', NULL, '185.242.226.163', 'Python/3.7 aiohttp/3.8.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzAyM1dQRFc3QnlNa09FMjloRmt1OHNRcEpZcDd3enpJZVc3enNZVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748012219),
('w8xdrXzidHEoQZ4Qmv7AKGStNkfZG1bFBIOhkGKY', NULL, '205.210.31.170', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMklOVnB5a1ZQSWFUOHNaMWdlcjk2UzgzZjVxemYyYkd4Z0FZWHducyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748311018),
('wD37SeN37fZSBO0WIRvQW0jYeOt6RbvlotUrLDLz', NULL, '104.23.6.41', 'Cloudflare-SSLDetector', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRmlJV1NFcW1pYXdLbkhEWFNZYlZtbzJramhqOEc5d3pqcVBWamxrTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHBzOi8vaG9seS1zdG9ybS1tc3Z2cGxlcmFjLnBsb2kuc2giO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748170715),
('WkNwhhWFp2lNpAjuTaPVYUSPyYUeGzchpAakNt3o', NULL, '198.235.24.179', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibVJnS2k1ZmtsMkJLMXZFeEZ0TXU0MHNmTExsbnVRV0xqb1RSTmJ1byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748233165),
('Wl30rUFIlFdrqHXsvGkaVWK5ETeTNEBz92uOXmMI', NULL, '155.94.172.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTWZuM2UyN1ZySzB6WWg5bURoUW9wMlRzMkF0UjBXMXltOW42VVAzUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748177786),
('wlOqgANGSBNkyzm3qobQFmCnfzHP4WsBtNGFLHYH', NULL, '185.12.124.78', 'Mozilla/5.0 (compatible; BackupLand/1.0; https://go.backupland.com/; Domain check for viruses;)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMERsYzdONnhtdndiQTdscmhqbDgzZFFrSEdZQVlMQUU3RDhJU3Z5ViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748141797),
('wNwyOxVV2DbYS7zoblmNlq8q1p5OOyeJAEF3AeY2', NULL, '82.102.18.190', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieEFXZjYya2xJSVd5QjV1cG9FU09WWnVqdzV5dTNzcWhRcEJGeHdFNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748304098),
('wvNi5eCZMWct7DJ001kA5PjvyYMY5kvQt1Fsp2MF', NULL, '206.189.139.235', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRFNONERGUkN2MG1qc2tBRndpNmhzSHBDRnF2VmJTdmNKQVNmUkVaSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748166017),
('X4Xqwg3ymWTvr8U7g3cwSuXgI2ixO8CanWda4KPX', NULL, '46.158.113.190', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiS3Y1eUV0ZVNLN0ZJRUlSODFVOTBwUkwxWTZTUU9Nck14VXU5WlVoeCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNToiaHR0cHM6Ly9nb2xkc2hpbmV0cmFkZS5ydS9kYXNoYm9hcmQiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMToiaHR0cHM6Ly9nb2xkc2hpbmV0cmFkZS5ydS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748157626),
('X8dC6EV2qu69A7kYZTvKKJwssPBN6wfFc3KDzFB7', 1, '176.59.78.221', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMHN1RGtHMzVtNEhONm1TUWxiZGhUQjdBOHJOeVQxYkQzcUVWV1VJViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1748092709),
('x8STMVCXnbL3doiA1khjPq8b5xX5bCpqy4AJWX8c', NULL, '52.90.85.64', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRkdKcDJUaDN3M0VoaXpZdVI1VVo2QVJSTW9wRDVtTWN1dk10blJRRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748194785),
('x9TsAeft6QwG87Zdzlo1BxjoBRxe7lkYuiC2s2ny', NULL, '46.159.90.193', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTHB4RURKNXhIbGJxZ2lwdnBlZlhNQVBkTlZiRnFsZ3BFa1lhNExwRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748214627),
('xaWbNvtc3mkyFFPS8epQMG16XHjFQhlYS1fukQi0', NULL, '213.171.2.30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicTYyV1VrWVdtOHhHbFU5cmFyT0pmOTZoUGJ6bUlGZ3hqbzU0aFhNcSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO319', 1748349209),
('XHwvDSmPbtzJKLBiEYDHEG8JElSEk8HzLraUPuvF', NULL, '172.105.128.11', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSFZGOFJqRFFNMlRkcDhHeksyZ1IyZ3lva3lDMHJTQ0taZFh4TmVSZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748446707),
('xjW2YJYUmGUoUIBSKVfVYPOxjHNeIAKSPc52DVMX', NULL, '62.109.13.133', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ0lMMXBGYmdyVzBnYjgyeFBPRzVRaXVROTgwSDhVUnQyNFY0MUJFdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748366318),
('XkERsAQtfPx8vaHngQXd05uNyo1EPeloYbKCqxHA', NULL, '162.142.125.118', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRGQ4WUtjelJweTAwSmlSVjMxRGFjR2xtdW96Tll5NkJsQ1FVMWgyWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748328926),
('XnoqBzWIKLHwVUmsNrLDbea0tt1PXlF65kM6BPRO', NULL, '80.85.246.214', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU3VmanpFMUY3QXMya0pPY0M3eVh0TUZkMHdkWG1Qd3l5V3R3bFltdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748141134),
('XREbdBW3mMYU4AtlAsgmSJ4i6mmM9x4y3uA2tqOE', NULL, '2a06:98c0:360b:4998:ae0e:5b16:a3cb:e9ab', 'Cloudflare-SSLDetector', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOHhzZUlBQU85eVIxQUJnRU5scmJVeGxDTEw0c3B6OTB5dEk5ODd6ZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHBzOi8vaG9seS1zdG9ybS1tc3Z2cGxlcmFjLnBsb2kuc2giO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748170412),
('XvgHlRLv4gxIZiBsxSBB6XmzspPwIRLeO1kzXQkg', NULL, '65.49.20.67', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/101.0.4951.41 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTjFIZkFqcnlZSnk5ODRUS0owTXI1S2VDUFRDbTYzYUxMQXNEOUVkcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748394043),
('XYRqmFpSKfCDgq8SvyipTl8IdNbVjVoWw3j6yVPu', 4, '188.162.166.25', 'Mozilla/5.0 (Linux; Android 12; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.7103.61 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoia2R2bGI1alJBZDlETDBSb0N3TFBNT2p2SUVrNkhxcXV2MmNRamxGTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo0O30=', 1748245516),
('yGbkAr9CtDooI9uFXB3GzPhb5JpDqfMxPhp5fhRy', 1, '176.59.77.147', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWWlZcno4T2NReUg0a1pBSzlVWk1zcFhrMUJTVHR5UnhUSzZuam8ySiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUvYWRtaW4vdXNlcnMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1748278025),
('YixpDPASqBFlcdNYw5MTnwK9uOkf7E7Wdy8M2vHP', 1, '46.159.72.15', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoia011SDBNSEI3Q2J3NEpUQktiTlhKWjYzejFWRG1pNTBhNnI0aGdrRSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2dvbGRzaGluZXRyYWRlLnJ1L2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1748279554),
('YN8lQReVYZvhjMX92Qp6Ow8zcwNli6EqF8xwwJ7T', NULL, '185.242.226.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid0lPS1NIOURldTU0YlNtNlhPUE4xd0l2S2ZvTGdPZUdLampWMlVWbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748420420),
('YNtLL1TSVn4dCI8eZNCLLWV7IMmoeT95gmPqSENT', NULL, '124.223.193.19', 'Mozilla/5.0 (Linux; Android 10; LIO-AN00 Build/HUAWEILIO-AN00; wv) MicroMessenger Weixin QQ AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/78.0.3904.62 XWEB/2692 MMWEBSDK/200901 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidnR2OEpub1QyVXFhVkIwdEdsZDQ2ZUgyeHc5WGZoMENqdlp5NlpaVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vd3d3LmdvbGRzaGluZXRyYWRlLnJ1Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748027593),
('YPGSsqMyJCy4yooVE0Ug0zuUknruQHhBNTZOybjH', NULL, '35.80.15.211', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/68.0.3440.106 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiODRMdDRjeXd4bkIwbGVmWVJGNW9zMFhSV0RhTkVFQmdiZnl6S3dTViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748127182),
('yREhwADi39tXkc4qRoPUEyt4awWFj3HIz3TTpn8c', NULL, '94.138.149.34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:138.0) Gecko/20100101 Firefox/138.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia3VUTjlWa2NTSmFZN0U3OHlhc3g1b0VBemczZmRPZHhCbGpKQzMydiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748338874),
('zG6WZI1UcfTvLKStm1IshtaVixtvIByabsdWDVrW', NULL, '34.86.212.119', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_3_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQnZMUjh1WkhMTHpOU0RaUW01ZHlzdmltODF3cmJhdnJta25acDgzOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748106405),
('zgcwLqSMQ4Ee5d6nJoB8xmtKFF6yhSgIAHl1uj0b', NULL, '91.246.41.166', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkVmYmk5WlQ3Z3duSm5EN00zRE0wSGdkOUJBeWNWeVFuUmpmNkc0WCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748387542),
('ZLp568gqCIisIEPZNEKUcaQr8GBLcAzvLbG4o1M0', NULL, '46.101.122.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/118.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWmpEM3dnZ25HZDZuR2NoU0EyblJFTDVYaG44cUtSSlRDaHZQSGpidSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748269165),
('ZPIsIn4PsUkYMz6rlggBCEy1lHEdkfp6if3kWsN1', NULL, '35.203.210.12', 'Expanse, a Palo Alto Networks company, searches across the global IPv4 space multiple times per day to identify customers&#39; presences on the Internet. If you would like to be excluded from our scans, please send IP addresses/domains to: scaninfo@paloaltonetworks.com', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0NoSlljdzIzRGxGSElrWUhWYUNaNmwwak1Hb2RPcEVobHpRUVNzdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748225404),
('ZQt2CRBNU1eJ7kr22V6bHmhfsrUT7Jcz2NNV4VE6', 1, '213.171.2.30', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiRGszc1BXV3VBM0hkRzFSdlhwRHc1bmlyVEY3VGdJSFZkTklwZmhiNCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwczovL2dvbGRzaGluZXRyYWRlLnJ1L2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1748240653),
('ZtVdPp7ys3WljLY8U2vJD3IOlTV3Ha67QxURuxj9', NULL, '3.143.33.63', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1ZmbFFUcWt5OUFQdjBiakk5QzBIYk9NcWNYOW9WUm5TSXhrZURPdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMTc2LjExMy44MC4xNTQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748317799),
('ZZwjMzOvzzP7S24SCe91pe6kQSfAs0CPWzcB7b9X', NULL, '62.109.13.133', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSlF5ZTEzSW5hTmJTckJxY2ZTQjg5SmR5dGtuWHVUQnZsYVRNQk1KOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vZ29sZHNoaW5ldHJhZGUucnUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748244750);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_verification_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_verified_at` timestamp NULL DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `adress` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `phone_verification_code`, `phone_verified_at`, `email_verified_at`, `balance`, `adress`, `photo`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Тигран Адамян', 'tigran05012002@mail.ru', NULL, NULL, NULL, NULL, 1010198.00, 'Tigranovka', 'profile-photos/XqamcE707uGXMexolWreeZq5WVaDq0YLdDtW7AlW.jpg', '$2y$12$M/S1BXx9Oq1eqiQWgK.M2ek4G2whjTRsJgfnXaYHLP2C8PC9nuGGC', NULL, '2025-05-23 09:47:54', '2025-05-27 06:46:21'),
(2, 'moon.dsdsdds', 'adamyan_05@bk.ru', NULL, NULL, NULL, NULL, 0.00, NULL, 'profile-photos/ZY1CHy4aTkCjcvt8vfJxeI7f3hek5UnbdiWYKhzc.jpg', '$2y$12$mBR9RCqgRseNoxe.Nsj8VuabuL8mRjYqJhS9EQ7mZabeRcP0oNo0O', NULL, '2025-05-24 09:49:02', '2025-05-24 09:49:40'),
(3, 'trrrr', 'forhetznerhost@gmail.com', NULL, NULL, NULL, NULL, 0.00, NULL, NULL, '$2y$12$BhluxS4ObfbkvR3VjO4XdeOwdu63MS6V6cEeiFm.m2IRMPsG5iOyG', NULL, '2025-05-26 05:09:07', '2025-05-26 05:09:07'),
(4, 'Фортепиано221', 'hochurolli@mail.ru', NULL, NULL, NULL, NULL, 0.00, NULL, NULL, '$2y$12$fuDSmGGHeHibmHgMbv/aYO5dWIGAeapqmlG8qQnM5j3oSDWaIn/NC', NULL, '2025-05-26 07:45:16', '2025-05-26 07:45:16');

-- --------------------------------------------------------

--
-- Структура таблицы `user_cards`
--

CREATE TABLE `user_cards` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `primary` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `user_cards`
--

INSERT INTO `user_cards` (`id`, `user_id`, `name`, `number`, `expiry`, `type`, `primary`, `created_at`, `updated_at`) VALUES
(1, 1, 'Мир', '5555', '09 35', 'МИР', 1, '2025-05-23 18:42:04', '2025-05-23 18:42:04');

-- --------------------------------------------------------

--
-- Структура таблицы `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','paid','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Индексы таблицы `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `deals`
--
ALTER TABLE `deals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deals_offer_id_foreign` (`offer_id`),
  ADD KEY `deals_buyer_id_foreign` (`buyer_id`),
  ADD KEY `deals_payment_method_id_foreign` (`payment_method_id`);

--
-- Индексы таблицы `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Индексы таблицы `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`),
  ADD KEY `games_category_id_foreign` (`category_id`),
  ADD KEY `games_game_type_id_foreign` (`game_type_id`);

--
-- Индексы таблицы `game_types`
--
ALTER TABLE `game_types`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Индексы таблицы `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_deal_id_foreign` (`deal_id`),
  ADD KEY `messages_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Индексы таблицы `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Индексы таблицы `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offers_user_id_foreign` (`user_id`),
  ADD KEY `offers_category_id_foreign` (`category_id`),
  ADD KEY `offers_game_id_foreign` (`game_id`),
  ADD KEY `offers_server_id_foreign` (`server_id`);

--
-- Индексы таблицы `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Индексы таблицы `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Индексы таблицы `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Индексы таблицы `servers`
--
ALTER TABLE `servers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `servers_game_id_foreign` (`game_id`);

--
-- Индексы таблицы `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Индексы таблицы `user_cards`
--
ALTER TABLE `user_cards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_cards_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `withdrawals_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `deals`
--
ALTER TABLE `deals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `games`
--
ALTER TABLE `games`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `game_types`
--
ALTER TABLE `game_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `offers`
--
ALTER TABLE `offers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `servers`
--
ALTER TABLE `servers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `user_cards`
--
ALTER TABLE `user_cards`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `deals`
--
ALTER TABLE `deals`
  ADD CONSTRAINT `deals_buyer_id_foreign` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `deals_offer_id_foreign` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `deals_payment_method_id_foreign` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `games`
--
ALTER TABLE `games`
  ADD CONSTRAINT `games_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `games_game_type_id_foreign` FOREIGN KEY (`game_type_id`) REFERENCES `game_types` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_deal_id_foreign` FOREIGN KEY (`deal_id`) REFERENCES `deals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `offers`
--
ALTER TABLE `offers`
  ADD CONSTRAINT `offers_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `offers_game_id_foreign` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `offers_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `offers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `servers`
--
ALTER TABLE `servers`
  ADD CONSTRAINT `servers_game_id_foreign` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `user_cards`
--
ALTER TABLE `user_cards`
  ADD CONSTRAINT `user_cards_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD CONSTRAINT `withdrawals_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
