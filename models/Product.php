<?php

namespace app\models;

class Product extends DbModel
{
    protected $id;
    protected $name;
    protected $description;
    protected $price;
    protected $catalog_id;
    protected $created_at;
    protected $updated_at;


    public function __construct($name = null, $description = null, $price = null, $catalog_id = null, $created_at = null, $updated_at = null)
    {
        $this->name = $name;
        $this->description = $description;
        $this->price = $price;
        $this->catalog_id = $catalog_id;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }


    public function getTableName()
    {
        return 'products';
    }


}