<?php

namespace app\models\repositories;

use app\engine\Db;
use app\models\entities\ProductFeedback;
use app\models\Repository;

class ProductFeedBackRepository extends Repository
{
    public function getTableName()
    {
        return 'product_feedback';
    }
    public function getEntityClass()
    {
        return ProductFeedback::class;
    }
    public function getAllFeeds()
    {
        $sql = "SELECT products.id as product_id, products.name as product_name, product_images.title as image_name, product_feedback.user_name, product_feedback.feedback, product_feedback.created_at FROM products 
        JOIN product_images ON product_images.product_id = products.id 
        JOIN product_feedback ON product_feedback.product_id = products.id ORDER BY product_feedback.updated_at DESC, product_feedback.created_at DESC;";
        return Db::getInstance()->queryAll($sql);
    }
}