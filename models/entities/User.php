<?php
namespace app\models\entities;

use app\models\Entity;

class User extends Entity
{
    public $id;
    public $name;
    public $birthday_at;
    public $pass_hash;
    public $hash;
    public $created_at;
    public $updated_at;


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