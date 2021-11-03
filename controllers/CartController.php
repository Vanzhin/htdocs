<?php

namespace app\controllers;

use app\engine\Db;
use app\models\OrdersProduct;
use app\models\Product;
use mysql_xdevapi\Statement;

class CartController extends Controller
{
    public function actionIndex()
    {
        if (isset($_SESSION['id'])){
            $sql = "SELECT orders_products.order_id, orders_products.product_id, orders_products.total AS quantity, products.name, orders_products.price, (orders_products.price*orders_products.total) AS totalPrice, SUM(orders_products.total * orders_products.price) OVER(PARTITION BY orders.id) AS grandTotal, product_images.title AS imageName FROM orders_products
            JOIN products ON products.id = orders_products.product_id
            JOIN product_images ON product_images.product_id = products.id
            JOIN orders ON orders.id = orders_products.order_id WHERE orders.status = 'active' AND orders.user_id = :value;";

            $basketData = Db::getInstance()->queryAll($sql, ['value' => $_SESSION['id']]);
        } else {
            $sql = "SELECT orders_products.order_id, orders_products.product_id, orders_products.total AS quantity, products.name, orders_products.price, (orders_products.price*orders_products.total) AS totalPrice, SUM(orders_products.total * orders_products.price) OVER(PARTITION BY orders_products.session_id) AS grandTotal, product_images.title AS imageName FROM orders_products
            JOIN products ON products.id = orders_products.product_id
            JOIN product_images ON product_images.product_id = products.id WHERE orders_products.session_id = :value;";

            $basketData = Db::getInstance()->queryAll($sql, ['value' => session_id()]);
        }
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
        if (isset($_GET['id'])){
            $productIdToBuy = $_GET['id'];

            $sql = "SELECT price FROM products WHERE id = :value; ";
            $productPrice = Db::getInstance()->queryOneResult($sql, ['value' => $productIdToBuy]);

            if (isset($_SESSION['id'])){//если пользователь авторизован, то добавление идет по его id, который лежит в {$_SESSION['id']}
                $sql = "SELECT user_id, id FROM orders WHERE status = 'active' AND user_id = :value ;";
                $hasUserActiveOrder = Db::getInstance()->queryOneResult($sql, ['value' => $_SESSION['id']]);
                if(!$hasUserActiveOrder){// добавляю заказ, если его еще нет
                    $order = new Order($_SESSION['id']);
                    $order->__set('session_id', session_id());
                    $order->save();
                }
                $sql = "SELECT user_id, id FROM orders WHERE status = 'active' AND user_id = :value;";
                $row = Db::getInstance()->queryOneResult($sql, ['value' => $_SESSION['id']]);
                $sql = "SELECT order_id, product_id FROM orders_products 
                JOIN orders ON orders.id = orders_products.order_id WHERE product_id = '$productIdToBuy' AND orders_products.order_id = {$row['id']};";
                $isInBasket = Db::getInstance()->queryOneResult($sql);
                if(!$isInBasket){
                    $basket = new OrdersProduct($row['id'], $productIdToBuy, '1', session_id(), $productPrice);
                    $basket ->save();
                } else{
                    $sql = "SELECT id FROM orders_products WHERE product_id = :id AND order_id = :order_id;";
                    $result = Db::getInstance()->queryOneResult($sql, ['id' => $productIdToBuy, 'order_id' => $row['id']]);
                    var_dump($result['id']);
                    $basket = new  OrdersProduct();
                    $basket = $basket->getOne($result['id']);
                    $basket -> __set('total', $basket->total + 1);
                    $basket->save();
                    var_dump($basket);
                }

            } else{// если пользователь не авторизован, то добавление идет по session_id
                $isInBasket = mysqli_query(getDb(),"SELECT product_id FROM orders_products WHERE product_id = '$productIdToBuy' AND session_id = '$session';");

                if($isInBasket -> num_rows === 0){
                    mysqli_query(getDb(), "INSERT INTO orders_products (product_id, total, session_id, price) VALUES('$productIdToBuy', '1', '$session', '$productPrice');");
                } else{
                    mysqli_query(getDb(), "UPDATE orders_products SET total = total + 1 WHERE product_id = '$productIdToBuy' AND session_id = '$session';");
                }
            }
            header("Location: " . $_SERVER['HTTP_REFERER']);
            die();
        }

    }
}