<?php

namespace app\models;

class ProductImage extends DbModel
{
    protected $id;
    protected $product_id;
    protected $title;

    public function __construct($product_id = null, $title = null)
    {
        $this->product_id = $product_id;
        $this->title = $title;
    }


    public function getTableName()
    {
        return 'product_images';
    }
}