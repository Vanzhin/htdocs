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
    public function actionIndex()
    {
        $message = (new Request())->getParams()['message'];
        $basketData = (new OrdersProductRepository())->getBasket();
        if(!$basketData){//если корзина пуста вывожу сообщение
            $basketEmpty = 'Козина пуста';
        }else {
            $basketPrice = $basketData[0]['grandTotal'];
        }

        $codes = [
            'order' => "Заказ оформлен",
        ];

        echo $this->render("cart",[
            'basketData' => $basketData,
            'basketEmpty' => $basketEmpty,
            'basketPrice' => $basketPrice,
            'orderMessage' =>$codes[$message],


        ]);
    }

    public function actionAdd()
    {
        $productIdToBuy = (new Request())->getParams()['id'];
        $product = (new ProductRepository())->getOne($productIdToBuy);
        if (isset($productIdToBuy)){
            $sessionId = (new Session())->getSessionId();
            if (isset($sessionId)){//если пользователь авторизован, то добавление идет по его id, который лежит в {$_SESSION['id']}
                $order = new OrderRepository();

                $order = $order->getOneObjWhere(['status' => 'active', 'user_id' => $sessionId]);

                if(!$order){// создаю заказ, если его еще нет
                    $order = new Order($sessionId);
                    $order->__set('session_id', session_id());
                    (new OrderRepository())->save($order);
                }
                // todo убарть из orders_products поле total
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

    public function actionDel()
    {
            $getId = (new Request())->getParams()['id'];
            $url = (new Request())->getStringReferer(); //получаю строку страницы без GET - запроса, делаю это на тот случай, если будут повторы с ошибками
            $url = explode('?', $url);
            $url = $url[0];
            $sessionId = (new Session())->getSessionId();

            if (isset($sessionId)){//если пользователь авторизован, то удаление идет по его id, который лежит в {$_SESSION['id']}
                $order = new OrderRepository();
                $order = $order->getOneObjWhere(['user_id' => $sessionId, 'status' => 'active']);
                $ordersProduct = new OrdersProductRepository();
                $ordersProduct = $ordersProduct->getOneObjWhere(['order_id' => $order->id, 'product_id' => $getId]);
                if (!$ordersProduct) {
                    header("Location: " . $url . "?message=error"); //выводит в строке браузера '/?message=error'
                    die();
                } else {
                    (new OrdersProductRepository())->delete($ordersProduct);
                }

            }else {// если пользователь не авторизован, то удаление идет по session_id
                $ordersProduct = new OrdersProductRepository();
                $ordersProduct = $ordersProduct->getOneObjWhere(['session_id' => session_id(), 'product_id' => $getId]);
                if (!$ordersProduct) {
                    header("Location: " . $url . "?message=error"); //выводит в строке браузера '/?message=error'
                    die();
                } else {
                    (new OrdersProductRepository())->delete($ordersProduct);
                }
            }
        $response = [
            'status' => 'ok',
            'sum' => (new OrdersProductRepository())->getBasket()[0]['grandTotal'],
            'total' => (new OrdersProductRepository())->getCountCart()['total'],
            'productTotal' => (new OrdersProductRepository())->getCountCart($getId)['total']
            ];

        echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        die();

    }
}