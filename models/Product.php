<?php

namespace app\models;

use app\engine\Db;

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
    public function getLimitCatalog($rowFrom = 1, $quantity = 1)
    {
        $sql = "SELECT DISTINCT products.id, products.name, products.price, product_images.title, COUNT(product_likes.product_id) OVER(PARTITION BY product_likes.product_id) AS likes FROM products 
        JOIN product_images ON product_images.product_id = products.id
        LEFT JOIN product_likes ON product_likes.product_id = products.id ORDER BY likes DESC LIMIT :rowFrom, :quantity;";
        return Db::getInstance()->queryLimit($sql, $rowFrom, $quantity);
    }

    public function getCard($id)
    {
        $sql = "SELECT DISTINCT products.id, products.name, products.price, product_images.title, COUNT(product_likes.product_id) OVER(PARTITION BY product_likes.product_id) AS likes FROM products 
        JOIN product_images ON product_images.product_id = products.id
        LEFT JOIN product_likes ON product_likes.product_id = products.id WHERE products.id = :id;";
        return Db::getInstance()->queryOneResult($sql, ['id' => $id]);
    }


}