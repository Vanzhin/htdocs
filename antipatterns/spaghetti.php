<?php

namespace app\controllers;

use app\engine\Auth;
use app\engine\Request;
use app\models\repositories\OrderRepository;
use app\models\repositories\OrdersProductRepository;

class AdminController extends Controller
{

    // Повторение обертки  if (Auth::is_admin()){} в каждом экшене. Использовать роутер для таких целей

    public function actionIndex()
    {
        if (Auth::is_admin()){
            echo $this->render("admin",[
                'ordersData' => (new OrderRepository())->getAllOrders(),
                'enumArr' => (new OrderRepository())->getEnumList('status'),

            ]);
        }else{
            echo $this->render('notFound');
        }

    }

    public function actionView()
    {
        if (Auth::is_admin()) {
            $id = (new Request())->getParams()['id'];
            $order = (new OrdersProductRepository())->getProductsInfoInOrder($id);
            echo $this->render("orderView", [
                'orderData' => $order,
                'orderId' => $id,

            ]);
        }else{
            echo $this->render('notFound');
        }
    }

    public function actionDel()
    {
        if (Auth::is_admin()) {
            $id = (new Request())->getParams()['id'];
            $order = (new OrderRepository())->getOneObjWhere(['id' => $id]);
            (new OrderRepository())->delete($order);
            header("Location: " . (new Request())->getStringReferer()); //возвращает на станицу, с которой пришел
            die();

        }else{
            echo $this->render('notFound');
        }
    }

    public function actionStatus()
    {
        if (Auth::is_admin()){
            $id = (new Request())->getParams()['id'];
            $status = (new Request())->getParams()['status'];
            $order = (new OrderRepository())->getOneObjWhere(['id' => $id]);
            $order->__set('status', $status);
            (new OrderRepository())->save($order);
            header("Location: " . (new Request())->getStringReferer()); //возвращает на станицу, с которой пришел
            die();
        }else{
            echo $this->render('notFound');
        }

    }

}