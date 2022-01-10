<?php

namespace app\models;
use app\interfaces\IModel;

abstract class Model implements IModel
{
    protected $props = [];


    public function __set($name, $value)
    {
//        если свойства нет, то ничего не происходит и нового свойства не создается
        if (property_exists($this, $this->$name)) {
            // если присваивается такое же значение, что и было, то ничего не происходит
            if ($this->$name !== $value){
                $this->props[$name] = true;
                $this->$name = $value;
            }

        }


    }

    public function __get($name)
    {
        return $this->$name;
    }


}