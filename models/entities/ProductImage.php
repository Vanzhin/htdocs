<?php

namespace app\models\entities;

use app\models\Entity;

class ProductImage extends Entity
{
    protected $id;
    protected $product_id;
    protected $title;

    public function __construct($product_id = null, $title = null)
    {
        $this->product_id = $product_id;
        $this->title = $title;
    }



}