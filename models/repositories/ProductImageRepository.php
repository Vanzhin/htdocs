<?php

namespace app\models\repositories;

use app\models\entities\ProductImage;
use app\models\Repository;

class ProductImageRepository extends Repository
{
    public function getTableName()
    {
        return 'product_images';
    }
    public function getEntityClass()
    {
        return ProductImage::class;
    }
}