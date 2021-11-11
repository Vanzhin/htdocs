<?php

namespace app\models\repositories;

use app\models\entities\ProductLike;
use app\models\Repository;

class ProductLikeRepository extends Repository
{
    function getTableName()
    {
        return 'product_likes';
    }
    public function getEntityClass()
    {
        return ProductLike::class;
    }
}