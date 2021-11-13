<?php

namespace app\controllers;

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
}