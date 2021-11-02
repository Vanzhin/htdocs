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
                header("Location: " . str_replace('?log=error', '',$_SERVER['HTTP_REFERER'])); //возвращает на станицу, с которой пришел, убирает /?log=error, если она там была
                die();
            } else{
                //todo сделать чтобы работало при ошибке со страниц localhost localhost/index
                $is_error = (stripos($_SERVER['HTTP_REFERER'], "?log=error") ? "" : "?log=error");// если в строке браузера уже есть log=error, то нового не ставит
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

    public function actionReg()
    {

        if (isset($_SESSION['id'])){
            header("Location: /");
            die();
        }
        if (isset($_POST['regSubmit'])){

            $login = $_POST['login'];
            $pass = $_POST['pass'];
            $passReenter = $_POST['pass_reenter'];
            $url = $_SERVER['REQUEST_URI']; //получаю строку страницы без GET - запроса, делаю это на тот случай, если будут повторы с ошибками
            $url = explode('?', $url);

            var_dump($url);
            $url = $url[0];

            if (empty($login) or empty($pass) or empty($passReenter)){
                header("Location: " . $url . "?message=null"); //возвращает на станицу, с которой пришел
                die();
            }
            if($pass !== $passReenter){
                header("Location: " . $url . "?message=pass"); //возвращает на станицу, с которой пришел
                die();
            }
            $user = new User($login);
            if ($user->getOneWhere('name', $login)){

                header("Location: " . $url . "?message=same"); //возвращает на станицу, с которой пришел
                die();

            }else{
                $user->__set('pass_hash', password_hash($pass, PASSWORD_DEFAULT));
                $user->save();
                if ($user->id){
                    header("Location: " . $url . "?message=reg"); //возвращает на станицу, с которой пришел
                    die();

                } else{
                    header("Location: " . $url . "?message=error"); //возвращает на станицу, с которой пришел
                    die();
                }
            }

        }
        $codes = [//массив с кодами для $message
            'pass' => "Введенные пароли не совпадают",
            'null' => "Какое-то из полей осталось пустым, пожалуйста повторите ввод",
            'reg' => "Вы зарегистрированы",
            'error' => "Ошибка подключения к БД",
            'same' => "Пользователь с таким именем уже существует"

        ];

        $message = (isset($_GET['message'])) ? $codes[strip_tags($_GET['message'])] : "";// обрезает теги, и выводит значение message из строки браузера

        echo $this->render("registration", [
            'message' => $message,

        ]);
    }


}