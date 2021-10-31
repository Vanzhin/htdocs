<?php
use app\models\{Product, User, OrdersProduct, Order, ProductFeedback, ProductImage, ProductLike};
use app\engine\{Autoload, Db};
include "../engine/Autoload.php";
include '../config/config.php';
//регистрирует автозагрузчики и вызывает их, см урок php2.2
spl_autoload_register([new Autoload(), 'loadClass']);

//$_GET['c'] ?? 'product' тоже самое, что if(isset($_GET['c'])){$_GET['c']} else 'product';
//
//
//$product = new Product();
//$product = $product->getOne(181);
//$product->__set('name', 'calculator');
//$product->save();
//die();



$controllerName = $_GET['c'] ?? 'index';
$actionName = $_GET['a'];

$controllerClass = CONTROLLER_NAMESPACE . ucfirst($controllerName) . 'Controller';

if (class_exists($controllerClass)){
    $controller = new $controllerClass();
    $controller->runAction($actionName);
} else{
    die("not found 404");
}




