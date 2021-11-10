<?php

namespace app\models;

use app\engine\Db;

class ProductFeedback extends DbModel
{
    protected $id;
    protected $product_id;
    protected $user_name;
    protected $feedback;
    protected $session_id;
    protected $user_id;
    protected $created_at;
    protected $updated_at;



    public function __construct( $product_id = null, $user_name = null, $feedback = null, $session_id = null, $user_id = null)
    {
        $this->product_id = $product_id;
        $this->user_name = $user_name;
        $this->feedback = $feedback;
        $this->session_id = $session_id;
        $this->user_id = $user_id;
    }

    public function getTableName()
    {
        return 'product_feedback';
    }
    public function getAllFeeds()
    {
        $sql = "SELECT products.id as product_id, products.name as product_name, product_images.title as image_name, product_feedback.user_name, product_feedback.feedback, product_feedback.created_at FROM products 
        JOIN product_images ON product_images.product_id = products.id 
        JOIN product_feedback ON product_feedback.product_id = products.id ORDER BY product_feedback.updated_at DESC, product_feedback.created_at DESC;";
        return Db::getInstance()->queryAll($sql);
    }

}