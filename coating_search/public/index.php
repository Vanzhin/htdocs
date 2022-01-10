<?php
use app\models\{Product,User};
use app\engine\{Db, Autoload};
include "../config/config.php";

include "../engine/Autoload.php";


spl_autoload_register(
    [new Autoload(),
        'loadClass']
);

$controllerName = $_GET['c'] ?? 'product';
$actionName = $_GET['a'] ?? null;
$controllerClass = CONTROLLER_NAMESPACE . ucfirst($controllerName) . "Controller";

if (class_exists($controllerClass)){
    $controller = new $controllerClass;
    $controller->runAction($actionName);

}else {
    die('404');
}

die();
$product = Product::getOneObject(13);
////$product = new Product('hello22112111',1,1, date(DATE_ATOM));
//
var_dump($product);
echo "<br>";
//
$product->name = 'ggo1oo';
//$product->brand_name_id = 1;
var_dump($product);
echo "<br>";
//
//$product->save();
//
//echo "<br>";
//var_dump($product);
//echo "<br>";
//
