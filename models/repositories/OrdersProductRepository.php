<?php

namespace app\models\repositories;

use app\engine\Db;
use app\models\entities\OrdersProduct;
use app\models\Repository;

class OrdersProductRepository extends Repository
{
    public function getTableName()
    {
        return 'orders_products';
    }
    public function getEntityClass()
    {
        return OrdersProduct::class;
    }

    public function getCountCart($productId = null)
    {
        if ($productId){
            if (isset($_SESSION['id'])){

                $sql = "SELECT count(orders.id) AS total FROM orders_products
                    LEFT JOIN orders ON orders.id = orders_products.order_id 
                    WHERE orders.user_id = :value AND orders.status = 'active' AND product_id = :product_id;";
                return Db::getInstance()->queryOneResult($sql, ['value' => $_SESSION['id'], 'product_id' => $productId]);

            } else{
                $sql = "SELECT count(id) AS total FROM orders_products
                     WHERE session_id = :value AND product_id = :product_id;";
                return Db::getInstance()->queryOneResult($sql, ['value' => session_id(), 'product_id' => $productId]);
            }

        } else{
            if (isset($_SESSION['id'])){

                $sql = "SELECT count(orders.id) AS total FROM orders_products
                    LEFT JOIN orders ON orders.id = orders_products.order_id 
                    WHERE orders.user_id = :value AND orders.status = 'active';";
                return Db::getInstance()->queryOneResult($sql, ['value' => $_SESSION['id']]);


            } else{
                $sql = "SELECT count(id) AS total FROM orders_products
                     WHERE session_id = :value;";
                return Db::getInstance()->queryOneResult($sql, ['value' => session_id()]);

            }

        }

    }

    public  function getBasket()
    {
        if (isset($_SESSION['id'])){
            $sql = "SELECT  DISTINCT orders_products.order_id, orders_products.product_id, count(orders_products.order_id) OVER(PARTITION BY products.id) AS quantity, products.name, orders_products.price, (orders_products.price*orders_products.total) AS totalPrice, SUM(orders_products.total * orders_products.price) OVER(PARTITION BY orders.id) AS grandTotal, product_images.title AS imageName FROM orders_products
            JOIN products ON products.id = orders_products.product_id
            JOIN product_images ON product_images.product_id = products.id
            JOIN orders ON orders.id = orders_products.order_id WHERE orders.status = 'active' AND orders.user_id = :value;";

            $basketData = Db::getInstance()->queryAll($sql, ['value' => $_SESSION['id']]);
        } else {
            $sql = "SELECT DISTINCT orders_products.order_id, orders_products.product_id, count(orders_products.product_id) OVER(PARTITION BY products.id) AS quantity, products.name, orders_products.price, (orders_products.price*orders_products.total) AS totalPrice, SUM(orders_products.total * orders_products.price) OVER(PARTITION BY orders_products.session_id) AS grandTotal, product_images.title AS imageName FROM orders_products
            JOIN products ON products.id = orders_products.product_id
            JOIN product_images ON product_images.product_id = products.id WHERE orders_products.session_id = :value;";

            $basketData = Db::getInstance()->queryAll($sql, ['value' => session_id()]);
        }
        return $basketData;

    }

    public function getProductsInfoInOrder($id)
    {
        $sql ="SELECT  DISTINCT orders_products.order_id, orders_products.product_id, count(orders_products.order_id) OVER(PARTITION BY products.id) AS quantity, products.name, orders_products.price, (orders_products.price*orders_products.total) AS totalPrice, SUM(orders_products.total * orders_products.price) OVER(PARTITION BY orders.id) AS grandTotal, product_images.title AS imageName FROM orders_products
            JOIN products ON products.id = orders_products.product_id
            JOIN product_images ON product_images.product_id = products.id
            JOIN orders ON orders.id = orders_products.order_id WHERE orders.id = :id";
        return Db::getInstance()->queryAll($sql, ['id' => $id]);

    }
}