<?php

namespace app\engine;

use app\interfaces\IRender;

class TwigRender implements IRender
{
        protected $loader;
        protected $twig;


    public function __construct()
    {
        $this->loader = new \Twig\Loader\FilesystemLoader(TWIG_TEMPLATES_DIR);;
        $this->twig = new \Twig\Environment($this->loader);
        $this->twig->addExtension(new \Twig\Extension\DebugExtension());

    }


    public function renderTemplate($template, $params =[])
    {
        echo $this->twig->render($template . '.twig', $params);
    }
}