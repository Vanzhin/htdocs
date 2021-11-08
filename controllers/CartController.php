<?php

namespace app\controllers;

use app\engine\Db;
use app\engine\Request;
use app\engine\Session;
use app\models\{OrdersProduct, Order};

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
                // todo убарть из orders_products поле total
                $sql = "SELECT user_id, id FROM orders WHERE status = 'active' AND user_id = :value;";
                $row = Db::getInstance()->queryOneResult($sql, ['value' => $sessionId]);
                $ordersProduct = new OrdersProduct($row['id'], $productIdToBuy, '1', session_id(), $productPrice['price']);
                $ordersProduct ->save();

            } else{// если пользователь не авторизован, то добавление идет по session_id
                 $basket = new OrdersProduct();
                 $basket->__set('product_id', $productIdToBuy);
                 $basket->__set('total', 1);
                 $basket->__set('session_id', session_id());
                 $basket->__set('price', $productPrice['price']);
                 $basket ->save();

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
            $url = (new Request())->getStringReferer(); //получаю строку страницы без GET - запроса, делаю это на тот случай, если будут повторы с ошибками
            $url = explode('?', $url);
            $url = $url[0];
            $sessionId = (new Session())->getSessionId();

            if (isset($sessionId)){//если пользователь авторизован, то удаление идет по его id, который лежит в {$_SESSION['id']}
                $sql = "SELECT orders_products.id AS order_id, orders_products.product_id, orders.id FROM orders_products 
                JOIN orders ON orders.id = orders_products.order_id WHERE orders.user_id = :user_id AND orders.status = 'active' AND orders_products.product_id = :id;";
                $result = Db::getInstance()->queryOneResult($sql, ['user_id' => $sessionId, 'id' => $getId]);
                if (!$result) {
                    header("Location: " . $url . "?message=error"); //выводит в строке браузера '/?message=error'
                    die();
                } else {
                    $sql = "DELETE FROM orders_products WHERE order_id = :order_id AND product_id = :id;";
                    Db::getInstance()->queryOneResult($sql, ['order_id' => $result['id'], 'id' => $getId]);

//                    $order_product = new OrdersProduct();
//                    $order_product = $order_product->getOne($result['order_id']);
//                    $order_product->delete();
                }

            }else {// если пользователь не авторизован, то удаление идет по session_id
                $sql = "SELECT orders_products.id AS order_id, orders_products.product_id  FROM orders_products WHERE session_id = :session AND orders_products.product_id = :id;";
                $result = Db::getInstance()->queryOneResult($sql, ['session' => session_id(), 'id' => $getId]);
                if (!$result) {
                    header("Location: " . $url . "?message=error"); //выводит в строке браузера '/?message=error'
                    die();
                } else {
                    $sql = "DELETE FROM orders_products WHERE session_id = :session AND product_id = :id;";
                    Db::getInstance()->queryOneResult($sql, ['session' => session_id(), 'id' => $getId]);

//                    $order_product = new OrdersProduct();
//                    $order_product = $order_product->getOne($result['order_id']);
//                    $order_product->delete();
                }
            }
        $response = [
            'status' => 'ok',
            'sum' => OrdersProduct::getBasket()[0]['grandTotal'],
            'total' => OrdersProduct::getCountCart()['total'],
            ];

        echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        die();
//            header("Location: " . $url . "?message=del"); //выводит в строке браузера '/?message=del'
//            die();

    }
}