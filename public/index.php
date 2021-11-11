<?php
session_start();
$session = session_id();

use app\models\{Product, User, OrdersProduct, Order, ProductFeedback, ProductImage, ProductLike};
use app\engine\{Autoload, Db, Render, TwigRender, Request};

//include "../engine/Autoload.php";
include '../config/config.php';

//подключаю автозагрузчик Twig
require_once '../vendor/autoload.php';

//регистрирует автозагрузчики и вызывает их, см урок php2.2
// закомментировал потому, что регистрация идет автозагрузчиком вендора, эта конфигурация настраиваится
//spl_autoload_register([new Autoload(), 'loadClass']);

try {
    $request = new Request();


    $controllerName = $request->getControllerName() ? : 'index';

    $actionName = $request->getActionName() ?? '';
//проверяю есть ли $actionName символ "?" , который использую для вывода уведомлений
    if(strpbrk($actionName, '?')){
        $actionName = '';
    }
    $controllerClass = CONTROLLER_NAMESPACE . ucfirst($controllerName) . 'Controller';

// если класса контроллера нет, перенаправляю на главную
    if (!class_exists($controllerClass)){
        $controllerClass = CONTROLLER_NAMESPACE . 'IndexController';

    }
    $controller = new $controllerClass(new Render());
    $controller->runAction($actionName);
} catch (\PDOException $e){
var_dump($e);
} catch (\Exception $e){
    var_dump($e->getTrace());
}




