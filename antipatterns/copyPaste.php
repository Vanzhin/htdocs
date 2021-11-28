<?php

namespace app\controllers;

use app\engine\Request;
use app\engine\Session;
use app\models\repositories\OrderRepository;
use app\models\repositories\OrdersProductRepository;
use app\models\repositories\ProductRepository;
use app\models\entities\{OrdersProduct, Order};

class CartController extends Controller
{

    public function actionAdd()
    {
        $productIdToBuy = (new Request())->getParams()['id'];
        $product = (new ProductRepository())->getOne($productIdToBuy);
        if (isset($productIdToBuy)){
            $sessionId = (new Session())->getSessionId();

            /*методы добавления товара в корзину для авторизованного пользователя и не авторизованного отличаются
            не значительно. Подумать, как можно добавлять товар одним методом для всех, вынести часть одинакового кода
            на уровень выше*/

            if (isset($sessionId)){//если пользователь авторизован, то добавление идет по его id, который лежит в {$_SESSION['id']}
                $order = new OrderRepository();

                $order = $order->getOneObjWhere(['status' => 'active', 'user_id' => $sessionId]);

                if(!$order){// создаю заказ, если его еще нет
                    $order = new Order($sessionId);
                    $order->__set('session_id', session_id());
                    (new OrderRepository())->save($order);
                }
                $ordersProduct = new OrdersProduct($order->__get('id'), $productIdToBuy, '1', session_id(), $product->price);
                (new OrdersProductRepository())->save($ordersProduct);

            } else{// если пользователь не авторизован, то добавление идет по session_id
                $order = new OrderRepository();

                $order = $order->getOneObjWhere(['status' => 'active', 'session_id' => session_id()]);

                if(!$order){// создаю заказ, если его еще нет
                    $order = new Order(0, session_id(), 'active');
                    (new OrderRepository())->save($order);
                }
                $orderId = (new OrderRepository())->getIdWhere('session_id', session_id());
                $ordersProduct = new OrdersProduct($orderId['id'], $productIdToBuy, 1, session_id(), $product->price);
                (new OrdersProductRepository())->save($ordersProduct);

            }
            $response = [
                'status' => 'ok',
                'total' => (new OrdersProductRepository())->getCountCart()['total'],
            ];
            echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
            die();

        }

    }

}