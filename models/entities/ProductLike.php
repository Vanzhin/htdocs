<?php

namespace app\models\entities;

use app\models\Entity;

class ProductLike extends Entity
{
    public $id;
    public $product_id;
    public $session_id;
    public $user_id;
    public $created_at;

    public function __construct($product_id = null, $session_id = null, $user_id = null, $created_at = null)
    {
        $this->product_id = $product_id;
        $this->session_id = $session_id;
        $this->user_id = $user_id;
        $this->created_at = $created_at;
    }



}