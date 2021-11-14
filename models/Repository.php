<?php

namespace app\models;

use app\engine\Db;
use app\models\Entity;

abstract class Repository

{
    abstract function getTableName();
    abstract function getEntityClass();

    public function save(Entity $entity)
    {
        if(is_null($entity->id)){
            $this->insert($entity);
        } else{
            $this->update($entity);
        }
    }

    public function getOne($id)
    {
        $sql = "SELECT * FROM {$this->getTableName()} WHERE id = :id";
        //        return Db::getInstance()->queryOneResult($sql, ['id' => $id]);
        //        метод queryOneObject возвращает полноценный объект с заполненными из БД свойствами, указанного класса
        $obj = Db::getInstance()->queryOneObject($sql, ['id' => $id], $this->getEntityClass());
        // создаю массив с перечислением свойств из БД
        $obj->createProps($obj);
        return $obj;
    }

    public function getAll()
    {
        $sql = "SELECT * FROM {$this->getTableName()}";
        return Db::getInstance()->queryAll($sql);
    }

    public function getAllWhere($field, $value)
    {
        $sql = "SELECT * FROM {$this->getTableName()} WHERE {$field} = :value";
        return Db::getInstance()->queryAll($sql,['value' => $value]);
    }

    public function getCount()
    {
        $sql = "SELECT COUNT(*) FROM {$this->getTableName()}";
        return Db::getInstance()->queryAll($sql);
    }

    public function getCountWhere($field, $value)
    {
        $sql = "SELECT COUNT(*) AS count FROM {$this->getTableName()} WHERE $field = :value;";
        return Db::getInstance()->queryAll($sql, ['value' => $value]);

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
    public function getOneObjWhere($wheres = [])
    {
        $sql = "SELECT * FROM {$this->getTableName()}";
        if (!empty($wheres)) {
            $sql .= " WHERE ";
            foreach ($wheres as $key => $value) {
                $sql .= $key . " = :" . $key;
                if ($value != end($wheres)) $sql .= " AND ";
            }
        }

        $obj = Db::getInstance()->queryOneObject($sql, $wheres, $this->getEntityClass());
        // создаю массив с перечислением свойств из БД
        if ($obj){
            $obj->createProps($obj);
        }
        return $obj;
    }



    public function insert(Entity $entity)
    {//todo
        $params = [];
        foreach ($entity as $key => $value){
            if (is_null($value) || $key === 'propsFromDb') continue;
            $params[$key] = $value;
        }
        $keysToString = implode(", ", array_keys($params));
        $placeholders = ":" . implode(", :", array_keys($params));
        $sql = "INSERT INTO {$this->getTableName()} ({$keysToString}) VALUES ({$placeholders});";
        Db::getInstance()->execute($sql, $params);
        $entity->id = Db::getInstance()->lastInsertId();

    }

    public function delete(Entity $entity)
    {
        $id = $entity->id;
        $sql = "DELETE FROM {$this->getTableName()} WHERE id = :id;";
        Db::getInstance()->execute($sql, ['id' => $id]);
    }

    public function update(Entity $entity)
    {
        $id = $entity->id;
        $valuesToUpdate = [];
        foreach ($entity->propsFromDb as $key => $value){

            if ($value === '') continue;
            $valuesToUpdate[$key] = $key . "='" . $entity->$key . "'";
        }
        if(!empty($valuesToUpdate)){
            $updatedToString = implode(", ", $valuesToUpdate);
            $sql = "UPDATE {$this->getTableName()} SET {$updatedToString} WHERE id = :id;";
            Db::getInstance()->execute($sql, ['id' => $id]);
        }
    }
}