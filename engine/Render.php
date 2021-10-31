<?php

namespace app\engine;

use app\interfaces\IRender;

class Render implements IRender
{
// рендерит только шаблон
    public function renderTemplate($template, $params =[])
    {
        ob_start();
        extract($params);
        $templatePath = VIEWS_DIR . $template . ".php";
        if (file_exists($templatePath)){
            include $templatePath;

        } else{
            die('no method exists');
        }
        return ob_get_clean();
    }
}