<?php

namespace app\controllers;

use app\engine\Auth;
use app\models\User;

class AuthController extends Controller
{
    public function actionLogin()
    {

        if (isset($_POST['submit'])){
            $login = strip_tags($_POST['login']);
            $pass = strip_tags($_POST['pass']);

            if (Auth::auth($login, $pass)){
                if (isset($_POST['save'])){// записывает куки, если стоит галка "запомнить"
                    $hash = uniqid(rand(),true);
                    $id = $_SESSION['id'];
                    $user = new User();
                    $user = $user->getOne($id);
                    $user->__set('hash', $hash);
                    $user->update();
                    setcookie("hash",$hash, time() + 3600, '/');
                }
                header("Location: " . $_SERVER['HTTP_REFERER']); //возвращает на станицу, с которой пришел
                die();
            } else{
                //todo сделать чтобы рендер не вылетал, если заходишь с localhost.
                $is_error = (stripos($_SERVER['HTTP_REFERER'], "?log=error") ? "" : "&?log=error");// если в строке браузера уже есть log=error, то нового не ставит
                header("Location: " . $_SERVER['HTTP_REFERER'] . $is_error); //возвращает на станицу, с которой пришел, и параметр log
                die();
            }

        }
    }

    public function actionLogout()
    {
        if(isset($_POST['logout'])){// удаляет куки для пользователя
            setcookie("hash","", time() - 3600, '/');
            session_regenerate_id();
            session_destroy();
            header("Location: " . $_SERVER['HTTP_REFERER']); //возвращает на станицу, с которой пришел
            die();
        }
    }

}