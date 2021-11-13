<?php

namespace app\models;



abstract class Entity
{
    public $propsFromDb = [];

    public function __set($name, $value)
    {
        $this->setProps($name, $value);
        $this->$name = $value;
    }

    public function __get($name)
    {
        return $this->$name;
    }

    // нужен для Twig, когда тот подучает вместо массива объект
    public function __isset($name)
    {
        return isset($this->name);
    }

    //создаю массив propsFromDb
    public function createProps($obj)
    {
        foreach ($obj as $key => $value){
            if ($key =='propsFromDb') continue;
            $obj->propsFromDb[$key] = '';
        }
    }

    public function setProps($name, $value)
    {
        //вношу в массив propsFromDb значение, если ключ есть
        if ($this->$name != $value AND array_key_exists($name, $this->propsFromDb)){
            $this->propsFromDb[$name] = $value;
        }
    }


}