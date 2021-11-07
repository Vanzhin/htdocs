<?php

namespace app\controllers;

use app\engine\Db;
use app\engine\Request;
use app\engine\Session;
use app\models\{OrdersProduct, Order};
use app\models\Product;
use mysql_xdevapi\Statement;

class CartController extends Controller
{

    public function actionIndex()
    {
        $basketData = OrdersProduct::getBasket();
        if(!$basketData){//если корзина пуста вывожу сообщение
            $basketEmpty = 'Козина пуста';
        }else {
            $basketPrice = $basketData[0]['grandTotal'];
        }

        echo $this->render("cart",[
            'basketData' => $basketData,
            'basketEmpty' => $basketEmpty,
            'basketPrice' => $basketPrice,


        ]);
    }

    public function actionAdd()
    {
        $productIdToBuy = (new Request())->getParams()['id'];

        if (isset($productIdToBuy)){

            $sql = "SELECT price FROM products WHERE id = :value;";
            $productPrice = Db::getInstance()->queryOneResult($sql, ['value' => $productIdToBuy]);
            $sessionId = (new Session())->getSessionId();
            if (isset($sessionId)){//если пользователь авторизован, то добавление идет по его id, который лежит в {$_SESSION['id']}
                $sql = "SELECT user_id, id FROM orders WHERE status = 'active' AND user_id = :value;";
                $hasUserActiveOrder = Db::getInstance()->queryOneResult($sql, ['value' => $sessionId]);
                if(!$hasUserActiveOrder){// создаю заказ, если его еще нет
                    $order = new Order($sessionId);
                    $order->__set('session_id', session_id());
                    $order->save();
                }
                $sql = "SELECT user_id, id FROM orders WHERE status = 'active' AND user_id = :value;";
                $row = Db::getInstance()->queryOneResult($sql, ['value' => $sessionId]);
                $sql = "SELECT order_id, product_id FROM orders_products 
                JOIN orders ON orders.id = orders_products.order_id WHERE product_id = '$productIdToBuy' AND orders_products.order_id = {$row['id']};";
                $isInBasket = Db::getInstance()->queryOneResult($sql);
                if(!$isInBasket){
                    $basket = new OrdersProduct($row['id'], $productIdToBuy, '1', session_id(), $productPrice['price']);
                    $basket ->save();
                } else{
                    $sql = "SELECT id FROM orders_products WHERE product_id = :id AND order_id = :order_id;";
                    $result = Db::getInstance()->queryOneResult($sql, ['id' => $productIdToBuy, 'order_id' => $row['id']]);
                    $basket = new  OrdersProduct();
                    $basket = $basket->getOne($result['id']);
                    $basket -> __set('total', $basket->total + 1);
                    $basket->save();
                }

            } else{// если пользователь не авторизован, то добавление идет по session_id
                $sql = "SELECT product_id FROM orders_products WHERE product_id = :id AND session_id = :session;";
                $isInBasket = Db::getInstance()->queryOneResult($sql, ['id' => $productIdToBuy, 'session' => session_id()]);

                if(!$isInBasket){
                    $basket = new OrdersProduct();
                    $basket->__set('product_id', $productIdToBuy);
                    $basket->__set('total', 1);
                    $basket->__set('session_id', session_id());
                    $basket->__set('price', $productPrice['price']);
                    $basket ->save();
                } else{
                    $sql = "SELECT id FROM orders_products WHERE product_id = :id AND session_id = :session_id;";
                    $result = Db::getInstance()->queryOneResult($sql, ['id' => $productIdToBuy, 'session_id' => session_id()]);
                    $basket = new  OrdersProduct();
                    $basket = $basket->getOne($result['id']);
                    $basket -> __set('total', $basket->total + 1);
                    $basket->save();
                }
            }
            $response = [
                'status' => 'ok',
                'total' => OrdersProduct::getCountCart()['total'],
            ];
            echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
            die();
            //  header("Location: " . $_SERVER['HTTP_REFERER']);
            //  die();
        }

    }

    public function actionDel()
    {
            $getId = (new Request())->getParams()['id'];
            $url = $_SERVER['HTTP_REFERER']; //получаю строку страницы без GET - запроса, делаю это на тот случай, если будут повторы с ошибками
            $url = explode('?', $url);
            $url = $url[0];
            $sessionId = (new Session())->getSessionId();

            if (isset($sessionId)){//если пользователь авторизован, то удаление идет по его id, который лежит в {$_SESSION['id']}
                $sql = "SELECT orders_products.product_id, orders.id FROM orders_products 
                JOIN orders ON orders.id = orders_products.order_id WHERE orders.user_id = :user_id AND orders.status = 'active' AND orders_products.product_id = :id;";

                $result = Db::getInstance()->queryOneResult($sql, ['user_id' => $sessionId, 'id' => $getId]);
                if (!$result) {
                    header("Location: " . $url . "?message=error"); //выводит в строке браузера '/?message=error'
                    die();
                } else {
                    $sql = "DELETE FROM orders_products WHERE product_id = :product_id AND order_id = :order_id;";
                    Db::getInstance()->queryOneResult($sql, ['product_id' => $getId, 'order_id' => $result['id']]);

                }

            }else {// если пользователь не авторизован, то удаление идет по session_id
                $sql = "SELECT orders_products.product_id  FROM orders_products WHERE session_id = :session AND orders_products.product_id = :id;";
                $result = Db::getInstance()->queryOneResult($sql, ['session' => session_id(), 'id' => $getId]);
                if (!$result) {
                    header("Location: " . $url . "?message=error"); //выводит в строке браузера '/?message=error'
                    die();
                } else {
                    $sql = "DELETE FROM orders_products WHERE product_id = :product_id AND session_id = :session ;";
                    Db::getInstance()->queryOneResult($sql, ['product_id' => $getId, 'session' => session_id()]);
                     }
            }
        $basketData = OrdersProduct::getBasket();
        $response = [
            'status' => 'ok',
            'sum' => $basketData[0]['grandTotal'],
            'total' => OrdersProduct::getCountCart()['total'],
            ];

        echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        die();
//            header("Location: " . $url . "?message=del"); //выводит в строке браузера '/?message=del'
//            die();

    }
}