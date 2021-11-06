<?php

namespace app\engine;

class Session
{
    protected $sessionId;
    protected $sessionLogin;


    public function __construct()
    {
        $this->sessionId = $_SESSION['id'];
        $this->sessionLogin = $_SESSION['login'];

    }

    public function getSessionId()
    {
        return $this->sessionId;
    }

    public function getSessionLogin()
    {
        return $this->sessionLogin;
    }


    public function setSessionLogin($sessionLogin): void
    {
        $this->sessionLogin = $sessionLogin;
    }


    public function setSessionId($sessionId): void
    {
        $this->sessionId = $sessionId;
    }






}