<?php

namespace app\controllers;

use app\models\entities\User;
use app\models\repositories\UserRepository;
use app\engine\{Auth, Request, Session};

class AuthController extends Controller
{
    public function actionLogin()
    {

        if (isset((new Request())->getParams()['submit'])){
            $login = strip_tags((new Request())->getParams()['login']);
            $pass = strip_tags((new Request())->getParams()['pass']);

            if (Auth::auth($login, $pass)){
                if (isset((new Request())->getParams()['save'])){// записывает куки, если стоит галка "запомнить"
                    $hash = uniqid(rand(),true);
                    $id = (new Session())->getSessionId();
                    $user = new UserRepository();
                    $user = $user->getOne($id);
                    $user->__set('hash', $hash);
                    (new UserRepository())->update($user);
                    setcookie("hash",$hash, time() + 3600, '/');
                }
                header("Location: " . str_replace('?log=error', '', (new Request())->getStringReferer())); //возвращает на станицу, с которой пришел, убирает /?log=error, если она там была
                die();
            } else{
                //todo сделать чтобы работало при ошибке со страниц localhost localhost/index
                $is_error = (stripos((new Request())->getStringReferer(), "?log=error") ? "" : "?log=error");// если в строке браузера уже есть log=error, то нового не ставит
                header("Location: " . (new Request())->getStringReferer() . $is_error); //возвращает на станицу, с которой пришел, и параметр log
                die();
            }

        }
    }

    public function actionLogout()
    {
        if(isset((new Request())->getParams()['logout'])){// удаляет куки для пользователя
            setcookie("hash","", time() - 3600, '/');
            session_regenerate_id();
            session_destroy();
            header("Location: " . (new Request())->getStringReferer()); //возвращает на станицу, с которой пришел
            die();
        }
    }

    public function actionReg()
    {
        $sessionId = (new Session())->getSessionId();

        if (isset($sessionId)){
            header("Location: /");
            die();
        }
        if (isset((new Request())->getParams()['regSubmit'])){

            $login = (new Request())->getParams()['login'];
            $pass = (new Request())->getParams()['pass'];
            $passReenter = (new Request())->getParams()['pass_reenter'];
            $url = (new Request())->getRequestString(); //получаю строку страницы без GET - запроса, делаю это на тот случай, если будут повторы с ошибками
            $url = explode('?', $url);
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

            if ((new UserRepository())->getOneWhere('name', $login)){

                header("Location: " . $url . "?message=same"); //возвращает на станицу, с которой пришел
                die();

            }else{
                $user->__set('pass_hash', password_hash($pass, PASSWORD_DEFAULT));

                (new UserRepository())->save($user);
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

        $message = (isset((new Request())->getParams()['message'])) ? $codes[strip_tags((new Request())->getParams()['message'])] : "";// обрезает теги, и выводит значение message из строки браузера

        echo $this->render("registration", [
            'message' => $message,

        ]);
    }


}