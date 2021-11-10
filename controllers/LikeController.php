<?php

namespace app\controllers;

use app\engine\Request;
use app\engine\Session;
use app\models\OrdersProduct;
use app\models\ProductLike;

class LikeController extends Controller
{
    public function actionAdd()
    {
        $productId = (new Request())->getParams()['id'];
        $sessionId = (new Session())->getSessionId();

        $like = new ProductLike($productId, session_id(), 0);
        if (isset($sessionId)){
            $like->__set('user_id', $sessionId);
        }
        $like->save();
        $response = [
            'status' => 'ok',
            'likes' => $like->getCountWhere('product_id', $productId)[0]['count'],
        ];
        echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        die();

    }
}