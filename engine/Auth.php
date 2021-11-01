<?php

namespace app\engine;

use app\models\User;

class Auth
{
    public static function get_user()
    {// возвращает логин юзера
        return $_SESSION['login'];
    }

    public static function is_admin()
    {//
        return $_SESSION['login'] == 'admin';
    }

    public static function getLogMessage()
    {
        $codes = [//массив с кодами для $logMessage
            'error' => "Ошибка аутентификации",
        ];
        //если в строке содержится log=error, то присваивается значение $logMessage, которое выводится при не правильном пароле
        return (stripos($_SERVER['REQUEST_URI'], "log=error") ? $codes['error'] : "");

    }

    public static function is_auth()
    {// проверяет авторизован ли кто-то возвращает ответ в виде true или false, если true, то сообщает кто залогинился
        if (!isset($_SESSION['login']) and isset($_COOKIE["hash"])){// если в $_SESSION есть login, то тело не выполняется
            $hash = $_COOKIE["hash"];// берем из $_COOKIE значение hash и смотрим есть ли в базе
            $user = new User();
            $user = $user->getWhere('users.hash', $hash);
            $login = $user['name'];// присваиваем переменной $user значение из базы
            if (!empty($login)){
                $_SESSION['login'] = $login; // присваиваем $_SESSION['login'] значение из базы
                $_SESSION['id'] = $user['id'];// присваиваем $_SESSION['id'] значение из базы
            }
        }
        return isset($_SESSION['login']);
    }

    public static function auth($login, $pass)
    {// возвращает true с login и id пользователя, или false если пароль не верен
        $user = new User();
        $user = $user->getWhere('name', $login);

        if(password_verify($pass, $user['pass_hash'])){
            $_SESSION['login'] = $login;
            $_SESSION['id'] = $user['id'];
            session_regenerate_id();
            return true;
        }
        return false;
    }

}