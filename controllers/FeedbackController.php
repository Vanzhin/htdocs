<?php

namespace app\controllers;

use app\models\ProductFeedback;

class FeedbackController extends Controller
{
    public function actionFeeds()
    {
        $feeds = new ProductFeedback();
        $feeds = $feeds->getAll();
        echo $this->render("feedback", [
            'feeds' =>  $feeds,
        ]);
    }
}