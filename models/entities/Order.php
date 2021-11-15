<?php

namespace app\models\entities;


use app\models\Entity;

class Order extends Entity
{
    public $id;
    public $user_id;
    public $created_at;
    public $updated_at;
    public $session_id;
    public $status;
    public $name;
    public $tel;
    public $comment;


    public function __construct($user_id = null, $session_id = null, $status = null, $name = null, $tel = null, $comment = null, $created_at = null, $updated_at = null)
    {
        $this->user_id = $user_id;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
        $this->session_id = $session_id;
        $this->status = $status;
        $this->name = $name;
        $this->tel = $tel;
        $this->comment = $comment;
    }


}