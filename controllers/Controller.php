<?php

namespace app\controllers;

use app\engine\Auth;
use app\interfaces\IRender;
use app\models\repositories\OrdersProductRepository;

abstract class Controller
{
    private $action;
    private $defaultAction = 'index';
    private $layout = 'main';
    private $useLayout = true;
    private $render;


    public function __construct(IRender $render)
    {
        $this->render = $render;
    }


    public function runAction($action)
    {

        $this->action = $action  === '' ? $this->defaultAction : $action ;
        $method = "action" . ucfirst($this->action);
        if (method_exists($this,$method )){
            $this->$method();
        } else{
            die("class error");
        }
    }

// рендерит всю страницу
//todo разобраться еще раз
    public function render($template, $params = [])
    {
        if ($this->useLayout){
            return $this->renderTemplate('layouts/' . $this->layout,[
                'menu' => $this->renderTemplate('menu', [
                    'allow'=> Auth::is_auth(),
                    'login' => Auth::get_user(),
                    'logMessage' => Auth::getLogMessage(),
                    'cartCount' => (new OrdersProductRepository())->getCountCart(),
                    'isAdmin' => Auth::is_admin(),
                ]),
                'content' => $this->renderTemplate($template, $params),
                'footer' => $this->renderTemplate('footer', ['date' => date('Y')]),
            ]);
        }else{
            return $this->renderTemplate($template, $params);
        }
    }

    public function renderTemplate($template, $params)
    {
        return $this->render->renderTemplate($template, $params);
    }

}