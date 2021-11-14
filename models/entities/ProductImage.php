<?php

namespace app\models\entities;

use app\models\Entity;

class ProductImage extends Entity
{
    public $id;
    public $product_id;
    public $title;

    public function __construct($product_id = null, $title = null)
    {
        $this->product_id = $product_id;
        $this->title = $title;
    }



}