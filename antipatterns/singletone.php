<?php

namespace app\engine;
use app\traits\TSingleton;

class Db
{


    public $config = [
        'driver' => 'mysql',
        'host' => 'localhost:3306',
        'login' => 'test_user',
        'password' => '1234',
        'database' => 'shop',
        'charset' => 'utf8',
    ];

    // Использование паттерна Синглтон, при необходимости подключиться к другой базе надо создавать еще один класс с другими параметрами
    use TSingleton;

    private function prepareDsnString()
    {
        return sprintf("%s:host=%s;dbname=%s;charset=%s",
            $this->config['driver'],
            $this->config['host'],
            $this->config['database'],
            $this->config['charset'],
        );
    }

}