<?php
session_start();
$session = session_id();

use app\models\{Product, User, OrdersProduct, Order, ProductFeedback, ProductImage, ProductLike};
use app\engine\{Autoload, Db, Render, TwigRender};

include "../engine/Autoload.php";
include '../config/config.php';

//подключаю автозагрузчик Twig
require_once '../vendor/autoload.php';

//регистрирует автозагрузчики и вызывает их, см урок php2.2
spl_autoload_register([new Autoload(), 'loadClass']);


//
//
//$user = new User();
//$user = $user->getWhere('id',100009);
//var_dump($user);
//die();


//$_GET['c'] ?? 'index' тоже самое, что if(isset($_GET['c'])){$_GET['c']} else 'index';

$url = explode('/', $_SERVER['REQUEST_URI']);

$controllerName = $url[1] ? : 'index';
$actionName = $url[2] ?? '';

$controllerClass = CONTROLLER_NAMESPACE . ucfirst($controllerName) . 'Controller';

// если класса контроллера нет, перенаправляю на главную
if (!class_exists($controllerClass)){
    $controllerClass = CONTROLLER_NAMESPACE . 'IndexController';

}
$controller = new $controllerClass(new Render());
$controller->runAction($actionName);



