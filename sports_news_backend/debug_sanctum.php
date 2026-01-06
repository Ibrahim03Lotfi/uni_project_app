<?php
require __DIR__ . '/vendor/autoload.php';

if (trait_exists('Laravel\Sanctum\HasApiTokens')) {
    echo "Trait exists!";
    exit(0);
} else {
    echo "Trait NOT found!";
    exit(1);
}
