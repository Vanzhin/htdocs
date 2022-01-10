<?php

namespace app\controllers;

use app\models\Product;

class ProductController extends Controller
{

    public function actionIndex()
    {

        echo $this->render('index');

    }

    public function actionCatalog()
    {
        $page = $_GET['page'] ?? 0;
//        $catalog = Product::getLimit(($page + 1) * 2);
          $catalog = Product::getProductCatalogInfo();
        echo $this->render('product/catalog',[
            'catalog' => $catalog,
            'page' => ++$page,
        ]);
    }



    public function actionCard()
    {
        $id = $_GET['id'];
        $product = Product::getOneObject($id);
        echo $this->render('product/card',[
            'product' => $product,
        ]);
    }



}