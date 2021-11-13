<?php

namespace app\controllers;

use app\engine\Request;
use app\engine\Session;
use app\models\entities\ProductFeedback;
use app\models\repositories\ProductFeedBackRepository;

class FeedbackController extends Controller
{
    public function actionFeeds()
    {
        $feeds = new ProductFeedBackRepository();
        $feeds = $feeds->getAllFeeds();
        echo $this->render("feedback", [
            'feeds' =>  $feeds,
        ]);
    }
    public function actionAdd()
    {
//        $product_id = null, $user_name = null, $feedback = null, $session_id = null, $user_id = null
        $id = (new Request())->getParams()['id'];

        $prodId = (new Request())->getParams()['prod_id'];
        $text = (new Request())->getParams()['user_feedback'];
        $userName = (new Session())->getSessionLogin();
        $userId = (new Session())->getSessionId();
        $feedback =  new ProductFeedback();

        if ((new ProductFeedBackRepository())->getOne($id)){
            $feedback = (new ProductFeedBackRepository())->getOne($id);
            $feedback->__set('feedback', $text);
        } else{
            $feedback = new ProductFeedback($prodId, $userName, $text, session_id(), $userId);
        }
        (new ProductFeedBackRepository())->save($feedback);
        header("Location: " . (new Request())->getStringReferer()); //возвращает на станицу, с которой пришел

        die();
    }

    public function actionDel()
    {
        $id = (new Request())->getParams()['id'];
        $feedback = (new ProductFeedBackRepository())->getOne($id);
        (new ProductFeedBackRepository())->delete($feedback);
        header("Location: " . (new Request())->getStringReferer()); //возвращает на станицу, с которой пришел

        die();
    }

    public function actionEdit()
    {
        $id = (new Request())->getParams()['id'];

        $feedback = (new ProductFeedBackRepository())->getOne($id);
        $response = [
            'status' => 'ok',
            'feedbackText' => $feedback->feedback,
            'buttonText' => 'Обновить отзыв',
            'feedId' => $id,
        ];

        echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        die();
    }
}