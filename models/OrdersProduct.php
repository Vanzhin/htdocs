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


    public function __construct($order_id = null, $product_id = null, $total = null, $created_at = null, $updated_at = null, $session_id = null, $price = null)
    {
        $this->order_id = $order_id;
        $this->product_id = $product_id;
        $this->total = $total;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
        $this->session_id = $session_id;
        $this->price = $price;
    }


    public function getTableName()
    {
        return 'orders_products';
    }

    public static function getCountBasket()
    {
        if (isset($_SESSION['id'])){

            $sql = "SELECT SUM(orders_products.total) AS total FROM orders_products
                    LEFT JOIN orders ON orders.id = orders_products.order_id 
                    WHERE orders.user_id = :value AND orders.status = 'active';";
            return Db::getInstance()->queryOneResult($sql, ['value' => $_SESSION['id']]);


        } else{
            $sql = "SELECT SUM(orders_products.total) AS total FROM orders_products
                     WHERE session_id = :value;";
            return Db::getInstance()->queryOneResult($sql, ['value' => session_id()]);


        }

//        $sql = "SELECT count(id) FROM orders_products WHERE user_id = :value";
    }
}