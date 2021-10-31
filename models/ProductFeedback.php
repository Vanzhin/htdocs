<?php

namespace app\models;

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

}