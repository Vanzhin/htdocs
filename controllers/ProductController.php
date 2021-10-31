<?php

namespace app\controllers;

use app\models\Product;

class ProductController extends Controller
{

    public function actionCatalog()
    {
// если приходит запрос на добавление товаров  срабатывает это условие
        if (isset($_GET['showMore'])){
            $count = $_GET['showMore'];
            $catalog = new Product();
            $catalog = $catalog->getLimit($count, ITEMS_PER_PAGE);
            //рендерится только элемент-продукт
            echo $this->renderTemplate("product/productItem", [
                'catalog' =>  $catalog,
                'buyText' => 'Купить',
            ]);
            die();

        }
// вывожу только по 2 товара  на страницу, при нажатии кнопки еще два
// перехватываю клик джаваскриптом во вьехе catalog.php
        $page = $_GET['page'] ?? 0;
        $catalog = new Product();
        $catalog = $catalog->getLimit(0,($page + 1) * ITEMS_PER_PAGE);
        echo $this->render("product/catalog", [
            'catalog' =>  $catalog,
            'buyText' => 'Купить',
            'page'=> ++$page
        ]);


    }
    public function actionCard()
    {
        $id = $_GET['id'];
        $product = new Product();
        $product =  $product->getOne($id);
        echo $this->render('product/card', [
            'product' =>  $product,

        ]);
    }
}
