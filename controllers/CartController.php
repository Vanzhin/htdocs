<?php

namespace app\controllers;

use app\engine\Db;
use app\engine\Request;
use app\engine\Session;
use app\models\{OrdersProduct, Order, Product};
use phpDocumentor\Reflection\Types\Object_;

class CartController extends Controller
{
    public function actionIndex()
    {
        $basketData = OrdersProduct::getBasket();
        if(!$basketData){//если корзина пуста вывожу сообщение
            $basketEmpty = 'Козина пуста';
        }else {
            $basketPrice = $basketData[0]['grandTotal'];
        }

        echo $this->render("cart",[
            'basketData' => $basketData,
            'basketEmpty' => $basketEmpty,
            'basketPrice' => $basketPrice,


        ]);
    }

    public function actionAdd()
    {
        $productIdToBuy = (new Request())->getParams()['id'];
        $product = new Product();
        $product = $product->getOne($productIdToBuy);

        if (isset($productIdToBuy)){
            $sessionId = (new Session())->getSessionId();
            if (isset($sessionId)){//если пользователь авторизован, то добавление идет по его id, который лежит в {$_SESSION['id']}
                $order = new Order();
                $order = $order->getOneObjWhere(['status' => 'active', 'user_id' => $sessionId]);
                if(!$order){// создаю заказ, если его еще нет
                    $order = new Order($sessionId);
                    $order->__set('session_id', session_id());
                    $order->save();
                }
                // todo убарть из orders_products поле total
                $ordersProduct = new OrdersProduct($order->__get(id), $productIdToBuy, '1', session_id(), $product->price);
                $ordersProduct ->save();

            } else{// если пользователь не авторизован, то добавление идет по session_id
                $ordersProduct = new OrdersProduct(null, $productIdToBuy, 1, session_id(), $product->price);
                $ordersProduct ->save();

            }
            $response = [
                'status' => 'ok',
                'total' => OrdersProduct::getCountCart()['total'],
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
                $order = new Order();
                $order = $order->getOneObjWhere(['user_id' => $sessionId, 'status' => 'active']);
                $ordersProduct = new OrdersProduct();
                $ordersProduct = $ordersProduct->getOneObjWhere(['order_id' => $order->id, 'product_id' => $getId]);
                if (!$ordersProduct) {
                    header("Location: " . $url . "?message=error"); //выводит в строке браузера '/?message=error'
                    die();
                } else {
                    $ordersProduct->delete();
                }

            }else {// если пользователь не авторизован, то удаление идет по session_id
                $ordersProduct = new OrdersProduct();
                $ordersProduct = $ordersProduct->getOneObjWhere(['session_id' => session_id(), 'product_id' => $getId]);
                if (!$ordersProduct) {
                    header("Location: " . $url . "?message=error"); //выводит в строке браузера '/?message=error'
                    die();
                } else {
                    $ordersProduct->delete();
                }
            }
        $response = [
            'status' => 'ok',
            'sum' => OrdersProduct::getBasket()[0]['grandTotal'],
            'total' => OrdersProduct::getCountCart()['total'],
            'productTotal' => OrdersProduct::getCountCart($getId)['total']
            ];

        echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        die();

    }
}