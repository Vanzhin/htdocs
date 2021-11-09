<?php

namespace app\controllers;

use app\engine\Request;
use app\models\Product;

class ProductController extends Controller
{

    public function actionCatalog()
    {
        $count = (new Request())->getParams()['showMore'];
        $page = (new Request())->getParams()['page'] ?? 0;
        $catalog = new Product();



// если приходит запрос на добавление отрисовки товаров срабатывает это условие
        if (isset($count)){
            $catalog = $catalog->getLimitCatalog($count, ITEMS_PER_PAGE);
            //рендерится только элемент-продукт
            echo $this->renderTemplate("product/productItem", [
                'catalog' =>  $catalog,
                'buyText' => 'Купить',
            ]);
            die();

        }
// вывожу только по 2 товара на страницу, при нажатии кнопки еще два
// перехватываю клик джаваскриптом во вьюхе catalog .php или .twig
        $catalog = $catalog->getLimitCatalog(0,($page + 1) * ITEMS_PER_PAGE);
        echo $this->render("product/catalog", [
            'catalog' =>  $catalog,
            'buyText' => 'Купить',
            'page'=> ++$page
        ]);


    }

    public function actionCard()
    {
        $id = (new Request())->getParams()['id'];
        $product = new Product();
        $product =  $product->getCard($id);
        if ($product){
            echo $this->render('product/card', [
                'product' =>  $product,
                'buyText' => 'Купить',

            ]);
        } else{
            echo $this->render('notFound');

        }

    }

}
