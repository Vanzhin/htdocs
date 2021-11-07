<?php

namespace app\engine;

class Request
{
    protected $requestString;
    protected $controllerName;
    protected $actionName;
    protected $method;
    protected $stringReferer;
    protected $params = [];


    public function __construct()
    {
        $this->parseRequest();
    }
    protected function parseRequest()
    {
        $this->requestString = $_SERVER['REQUEST_URI'];
        $this->method = $_SERVER['REQUEST_METHOD'];
        $this->stringReferer = $_SERVER['HTTP_REFERER'];

        $url = explode('/', $this->requestString);

        $this->controllerName = $url[1];
        $this->actionName = $url[2];
        $this->params = $_REQUEST;

    }


    public function getRequestString()
    {
        return $this->requestString;
    }


    public function getControllerName()
    {
        return $this->controllerName;
    }


    public function getActionName()
    {
        return $this->actionName;
    }


    public function getMethod()
    {
        return $this->method;
    }


    public function getParams(): array
    {
        return $this->params;
    }


    public function getStringReferer()
    {
        return $this->stringReferer;
    }



}