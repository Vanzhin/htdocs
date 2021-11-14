<?php

namespace app\models\entities;

use app\models\Entity;

class Product extends Entity
{
    public $id;
    public $name;
    public $description;
    public $price;
    public $catalog_id;
    public $created_at;
    public $updated_at;


    public function __construct($name = null, $description = null, $price = null, $catalog_id = null, $created_at = null, $updated_at = null)
    {
        $this->name = $name;
        $this->description = $description;
        $this->price = $price;
        $this->catalog_id = $catalog_id;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }




}