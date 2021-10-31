<?php

namespace app\models;

class ProductLike extends DbModel
{
    protected $id;
    protected $product_id;
    protected $session_id;
    protected $user_id;
    protected $created_at;

    public function __construct($product_id = null, $session_id = null, $user_id = null, $created_at = null)
    {
        $this->product_id = $product_id;
        $this->session_id = $session_id;
        $this->user_id = $user_id;
        $this->created_at = $created_at;
    }


    function getTableName()
    {
        return 'product_likes';
    }
}