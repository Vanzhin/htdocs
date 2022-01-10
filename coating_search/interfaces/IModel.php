<?php

namespace app\interfaces;

interface IModel
{
    static public function getOne(int $id);
    static public function getAll();


}