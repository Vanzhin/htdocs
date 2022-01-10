<?php

namespace app\models;

class User extends DbModel
{
    protected $id;
    protected $nickname;
    protected $created_at;
    protected $updated_at;
    protected $pass_hash;
    protected $hash;
    protected $email;

    static protected function getTableName()
    {
        return 'users';
    }


}