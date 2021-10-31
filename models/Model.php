<?php

namespace app\models;


use app\interfaces\IModel;

abstract class Model implements IModel
{
    protected $propsFromDb = [];

    public function __set($name, $value)
    {
        $this->setProps($name, $value);
        $this->$name = $value;
    }

    public function __get($name)
    {
        return $this->$name;
    }

    //создаю массив propsFromDb
    protected function createProps($obj)
    {
        foreach ($obj as $key => $value){
            if ($key =='propsFromDb') continue;
            $obj->propsFromDb[$key] = '';
        }
    }

    protected function setProps($name, $value)
    {
        //вношу в массив propsFromDb значение, если ключ есть
        if ($this->$name != $value AND array_key_exists($name, $this->propsFromDb)){
            $this->propsFromDb[$name] = $value;
        }
    }


}