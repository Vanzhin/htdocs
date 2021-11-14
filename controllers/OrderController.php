<?php

namespace app\controllers;

use app\engine\Request;
use app\engine\Session;
use app\models\entities\Order;
use app\models\repositories\OrderRepository;

class OrderController extends Controller
{
    public function actionIndex()
    {
        echo $this->render("order",[
            'ordersData' => (new OrderRepository())->getAllOrders(),
            'userOrderData' => (new OrderRepository())->getOrderDetails(),
            'totalPrice' => (new OrderRepository())->getAllOrders()[0]['grandTotal'],

        ]);
    }

    public function actionAdd()
    {
        $name = (new Request())->getParams()['name'];
        $tel = (new Request())->getParams()['tel'];
        $sessionId = (new Session())->getSessionId();

        $url = (new Request())->getStringReferer(); //получаю строку страницы без GET - запроса, делаю это на тот случай, если будут повторы с ошибками
        $url = explode('?', $url);
        $url = $url[0];

        if (empty($name) or empty($tel)) {
            header("Location: " . $url . "?message=empty"); //возвращает на станицу, с которой пришел
            die();
        }
        if (isset($sessionId)) {
            $order = (new OrderRepository())->getOneObjWhere(['status' => 'active', 'user_id' => $sessionId]);
            $order->__set('status','handling');


        } else {//создаю заказ с user_id = 0
            $order = new Order(0, session_id(), 'handling');

        }
        foreach ((new Request())->getParams() as $key => $value){
            $order->__set($key,$value);
        }
        (new OrderRepository())->save($order);
        session_regenerate_id();
        header("Location: " . $url . "?message=order"); //возвращает на станицу, с которой пришел
        die();
    }
}