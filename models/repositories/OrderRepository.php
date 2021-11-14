<?php

namespace app\models\repositories;

use app\engine\Db;
use app\engine\Session;
use app\models\entities\Order;
use app\models\Repository;

class OrderRepository extends Repository
{
    public function getTableName()
    {
        return 'orders';
    }
    public function getEntityClass()
    {
        return Order::class;
    }

    public function getAllOrders()
    {
        $sessionId = (new Session())->getSessionId();
        $sql ="SELECT DISTINCT SUM(orders_products.total * orders_products.price) OVER(PARTITION BY orders.id) AS orderTotal, SUM(orders_products.total * orders_products.price) OVER(PARTITION BY orders.user_id) AS grandTotal, orders.id, orders.created_at, orders.updated_at, orders.status
        FROM orders_products
        JOIN products ON products.id = orders_products.product_id
        JOIN orders ON orders.id = orders_products.order_id 
        WHERE orders.user_id = :sessionId
        ORDER BY orders.created_at DESC;";
        return Db::getInstance()->queryAll($sql, ['sessionId' => $sessionId]);

    }

    public function getOrderDetails()
    {
        $sessionId = (new Session())->getSessionId();
        $sql = "SELECT DISTINCT orders_products.order_id, orders_products.product_id, count(orders_products.total) OVER(PARTITION BY products.id) AS quantity, products.name, orders_products.price, SUM(orders_products.total * orders_products.price) OVER(PARTITION BY products.id) AS totalPrice, product_images.title AS imageName FROM orders_products
        JOIN products ON products.id = orders_products.product_id
        JOIN product_images ON product_images.product_id = products.id
        JOIN orders ON orders.id = orders_products.order_id WHERE orders.user_id = :sessionId;";
        return Db::getInstance()->queryAll($sql, ['sessionId' => $sessionId]);

    }
}