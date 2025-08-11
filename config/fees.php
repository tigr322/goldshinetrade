<?php
// config/fees.php
return [
    // модель: buyer_pays | seller_pays | split
    'model' => env('FEE_MODEL', 'buyer_pays'),

    // проценты по умолчанию
    'buyer_percent'  => (float) env('FEE_BUYER_PERCENT', 3.5), // старт: 3.5% платит покупатель
    'seller_percent' => (float) env('FEE_SELLER_PERCENT', 0),  // продавцу ничего не удерживаем

    // на будущее: для сплита
    'split' => [
        'buyer_percent'  => (float) env('FEE_SPLIT_BUYER_PERCENT', 2.0),
        'seller_percent' => (float) env('FEE_SPLIT_SELLER_PERCENT', 3.0),
    ],

    // комиссия платёжки (чтобы прозрачно показывать пользователям)
    'payment_gateway_percent' => (float) env('PAYMENT_FEE_PERCENT', 3.5),
];
