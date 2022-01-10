<?php

namespace app\models;

use app\engine\Db;

class Product extends DbModel
{

    protected $id;
    protected $name;
    protected $brand_name_id;
    protected $catalog_id;
    protected $created_at;
    protected $description;

    /**
     * @param $name
     * @param $brand_name_id
     * @param $catalog_id
     * @param $created_at
     * @param $description
     */
    public function __construct($name = null, $brand_name_id = null, $catalog_id = null, $created_at = null, $description = null)
    {
        $this->name = $name;
        $this->brand_name_id = $brand_name_id;
        $this->catalog_id = $catalog_id;
        $this->created_at = $created_at;
        $this->description = $description;
    }


    static protected function getTableName()
    {
        return 'products';
    }

    static public function getProductCatalogInfo()
    {
        $sql = "SELECT
products.id AS id,       
products.name AS name, 
products.description AS description, 
brands.name AS brand,
catalogs.name AS catalog,
binders.name AS binder,
pds.url AS pds_link
 
FROM products
JOIN brands ON brands.id = products.brand_name_id
JOIN catalogs ON catalogs.id = products.catalog_id
LEFT JOIN product_binders ON product_binders.product_id = products.id
LEFT JOIN binders ON binders.id = product_binders.binder_id
LEFT JOIN pds ON pds.product_id = products.id;";
        return Db::getInstance()->queryAll($sql);
    }


}