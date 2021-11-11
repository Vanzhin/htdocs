<?php

namespace app\models\entities;

use app\models\Entity;


class OrdersProduct extends Entity
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



}