<?php
return [
    'token' => env('CKASSA_SHOP_TOKEN'),
    'secret' => env('CKASSA_SEC_KEY'),
    'code' => env('CKASSA_SHOP_CODE'),
    'url'=> env('CKASSA_URL', 'https://api2.ckassa.ru/api-shop/rs/open/invoice/create2'),
];