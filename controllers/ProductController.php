<?php

namespace app\controllers;

use app\engine\Auth;
use app\engine\Request;
use app\engine\Session;
use app\models\repositories\ProductFeedBackRepository;
use app\models\repositories\ProductRepository;

class ProductController extends Controller
{

    public function actionCatalog()
    {
        $count = (new Request())->getParams()['showMore'];
        $page = (new Request())->getParams()['page'] ?? 0;
        $catalog = new ProductRepository();

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
        $product = new ProductRepository();
        $product =  $product->getCard($id);
        if ($product){
            echo $this->render('product/card', [
                'product' =>  $product,
                'buyText' => 'Купить',
                'feedbackData' => (new ProductFeedBackRepository())->getAllWhere('product_id', $id),
                'isAuth' => Auth::is_auth(),
                'buttonText' => 'Оставить',
                'user_id' => (new Session())->getSessionId(),

            ]);
        } else{
            echo $this->render('notFound');

        }

    }


}
