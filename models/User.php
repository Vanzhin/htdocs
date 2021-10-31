<?php
namespace app\models;

class User extends DbModel
{
    protected $id;
    protected $name;
    protected $birthday_at;
    protected $pass_hash;
    protected $hash;
    protected $created_at;
    protected $updated_at;


    public function __construct($name = null, $birthday_at = null, $pass_hash = null, $hash = null, $created_at = null, $updated_at = null)
    {
        $this->name = $name;
        $this->birthday_at = $birthday_at;
        $this->pass_hash = $pass_hash;
        $this->hash = $hash;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }


    public function getTableName()
    {
        return 'users';
    }

}