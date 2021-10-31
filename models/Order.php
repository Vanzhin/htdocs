<?php

namespace app\models;


class Order extends DbModel
{
    protected $id;
    protected $user_id;
    protected $created_at;
    protected $updated_at;
    protected $session_id;
    protected $status;
    protected $name;
    protected $tel;
    protected $comment;


    public function __construct($user_id = null, $created_at = null, $updated_at = null, $session_id = null, $status = null, $name = null, $tel = null, $comment = null)
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

    public function getTableName()
    {
        return 'orders';
    }
}