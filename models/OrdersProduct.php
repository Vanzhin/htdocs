<?php

namespace app\models;
use app\engine\Db;


class OrdersProduct extends DbModel
{
    protected $id;
    protected $order_id;
    protected $product_id;
    protected $total;
    protected $created_at;
    protected $updated_at;
    protected $session_id;
    protected $price;


    public function __construct($order_id = null, $product_id = null, $total = null,  $session_id = null, $price = null, $created_at = null, $updated_at = null)
    {
        $this->order_id = $order_id;
        $this->product_id = $product_id;
        $this->total = $total;
        $this->session_id = $session_id;
        $this->price = $price;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }


    public function getTableName()
    {
        return 'orders_products';
    }

    public static function getCountCart()
    {
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

    public static function getBasket()
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
}