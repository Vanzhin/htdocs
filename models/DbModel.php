<?php

namespace app\models;

use app\engine\Db;

abstract class DbModel extends Model

{
    abstract function getTableName();

    public function save()
    {
        if(is_null($this->id)){
            $this->insert();
        } else{
            $this->update();
        }
    }

    public function getOne($id)
    {
        $sql = "SELECT * FROM {$this->getTableName()} WHERE id = :id";
        //        return Db::getInstance()->queryOneResult($sql, ['id' => $id]);
        //        метод queryOneObject возвращает полноценный объект с заполненными из БД свойствами, указанного класса
        $obj = Db::getInstance()->queryOneObject($sql, ['id' => $id], get_called_class());
        // создаю массив с перечислением свойств из БД
        $this->createProps($obj);
        return $obj;
    }

    public function getAll()
    {
        $sql = "SELECT * FROM {$this->getTableName()}";
        return Db::getInstance()->queryAll($sql);
    }

    public function getCount()
    {
        $sql = "SELECT COUNT(*) FROM {$this->getTableName()}";
        return Db::getInstance()->queryAll($sql);
    }


    public function getLimit($rowFrom, $quantity)
    {
        $sql = "SELECT * FROM {$this->getTableName()} LIMIT :rowFrom, :quantity";
        return Db::getInstance()->queryLimit($sql, $rowFrom, $quantity);
    }

    public function getOneWhere($name, $value)
    {
        $sql = "SELECT * FROM {$this->getTableName()} WHERE {$name} = :value";
        return Db::getInstance()->queryOneResult($sql, ['value' => $value]);
    }



    public function insert()
    {
        $params = [];
        foreach ($this as $key => $value){
            if (is_null($value) or $key === 'propsFromDb') continue;
            $params[$key] = $value;
        }
        echo "<br>";
        $keysToString = implode(", ", array_keys($params));
        $placeholders = ":" . implode(", :", array_keys($params));
        $sql = "INSERT INTO {$this->getTableName()} ({$keysToString}) VALUES ({$placeholders});";
        Db::getInstance()->execute($sql, $params);
        $this->id = Db::getInstance()->lastInsertId();

        return $this;
    }

    public function delete()
    {
        $id = $this->id;
        $sql = "DELETE FROM {$this->getTableName()} WHERE id = :id;";
        Db::getInstance()->execute($sql, ['id' => $id]);
        return $this;
    }

    public function update()
    {
        $id = $this->id;
        $valuesToUpdate = [];
        foreach ($this->propsFromDb as $key => $value){

            if ($value === '') continue;
            $valuesToUpdate[$key] = $key . "='" . $this->$key . "'";
        }
        if(!empty($valuesToUpdate)){
            $updatedToString = implode(", ", $valuesToUpdate);
            $sql = "UPDATE {$this->getTableName()} SET {$updatedToString} WHERE id = :id;";
            Db::getInstance()->execute($sql, ['id' => $id]);
        }
        return $this;
    }
}