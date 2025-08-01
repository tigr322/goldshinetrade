<?php
return [
    'shop_token' => env('CKASSA_SHOP_TOKEN'),
    'secret_key' => env('CKASSA_SEC_KEY'),
    'serv_code'  => env('CKASSA_SHOP_CODE'),
    'url'        => env('CKASSA_URL', 'https://api2.ckassa.ru/api-shop/rs/open/invoice/create2'),
    'encryption_key' => env('CKASSA_ENCRYPT_KEY'),


];