<?php

namespace app\controllers;

class indexController extends Controller
{
    public function actionIndex()
    {

        echo $this->render("index");
    }
}