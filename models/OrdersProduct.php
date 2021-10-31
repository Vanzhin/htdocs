<?php

namespace app\models;

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
}