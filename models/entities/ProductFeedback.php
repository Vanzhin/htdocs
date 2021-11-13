<?php

namespace app\models\entities;

use app\models\Entity;

class ProductFeedback extends Entity
{
    public $id;
    public $product_id;
    public $user_name;
    public $feedback;
    public $session_id;
    public $user_id;
    public $created_at;
    public $updated_at;



    public function __construct( $product_id = null, $user_name = null, $feedback = null, $session_id = null, $user_id = null)
    {
        $this->product_id = $product_id;
        $this->user_name = $user_name;
        $this->feedback = $feedback;
        $this->session_id = $session_id;
        $this->user_id = $user_id;
    }



}