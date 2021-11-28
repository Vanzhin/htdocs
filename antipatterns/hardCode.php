<?php

namespace app\engine;
use app\traits\TSingleton;

class Db
{
    /* свойство config - пример жесткого кода. Здесь класс Db единственный, но позже
    перестанет быть таковым. Передавать в Db данные с наружи при создании экземпляра класса, вынести
    настройки config в константу или массив, и поместить ее в config.php, а при  создании экземпляра выбирать
    нужную конфигурацию из имеющихся*/

    public $config = [
        'driver' => 'mysql',
        'host' => 'localhost:3306',
        'login' => 'test_user',
        'password' => '1234',
        'database' => 'shop',
        'charset' => 'utf8',
    ];

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