<?php

namespace App;

enum UserRole: string
{
    case SUPER_ADMIN = 'super_admin';
    case ADMIN = 'admin';
    case USER = 'user';
    
    public static function values(): array
    {
        return array_column(self::cases(), 'value');
    }
}
