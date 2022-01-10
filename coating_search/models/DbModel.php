<?php

namespace app\models;

use app\engine\Db;

abstract class DbModel extends Model
{
    static abstract protected function getTableName();


    static public function getOne( int $id)
    {
        $tableName = static::getTableName();
        $sql = "SELECT * FROM {$tableName} WHERE id = :id";
        return Db::getInstance()->queryOne($sql, ['id' => $id]);
    }

    static public function getOneObject(int $id)
    {
        $tableName = static::getTableName();

        $sql = "SELECT * FROM {$tableName} WHERE id = :id";
        return Db::getInstance()->queryOneObject($sql, ['id' => $id], static::class);
    }

    static public function getAll()
    {
        $tableName = static::getTableName();

        $sql = "SELECT * FROM {$tableName}";
        return Db::getInstance()->queryAll($sql);
    }

    static public function getLimit($limit)
    {
        $tableName = static::getTableName();

        $sql = "SELECT * FROM {$tableName} LIMIT 0, ?";
        return Db::getInstance()->queryLimit($sql, $limit);
    }


    public function insert()
    {
        $params = [];
        $tableName = static::getTableName();

        foreach ($this as $key => $value){
            if ($key === 'id') continue;
            $params[$key] = $value;
        }

        $keysToString = implode(", ", array_keys($params));
        $placeholders = ":" . implode(", :", array_keys($params));
        $sql = "INSERT INTO {$tableName} ({$keysToString}) VALUES ({$placeholders});";
        Db::getInstance()->execute($sql, $params);
        $this->id = Db::getInstance()->lastInsertId();
        return $this;
    }


    public function update()
    {
        $params = [];
        $tableName = static::getTableName();
// перебираю поля, которые изменились (из props)
        foreach ($this->props as $key => $value){
            $params[$key] = $this->$key;

        }
// если изменилось больше одного поля, начинаю запись в массив $updateArr
        if (count($params) >= 1){
            foreach ($params as $key => $value){
                $updateArr[] = "$key = :$key";
            }
            // добавляю в $params айдишник для того, чтобы исключить инъекцию
            $params['id'] = $this->id;
        }

        $updateString = implode(", ", $updateArr);
        $sql = "UPDATE {$tableName} SET {$updateString} WHERE id = :id;";
        Db::getInstance()->execute($sql, $params);
        $this->props = [];
        return $this;
    }

    public function delete()
    {
        $id = $this->id;
        $tableName = static::getTableName();
        $sql = "DELETE FROM {$tableName} WHERE id = :id;";
        Db::getInstance()->execute($sql, ['id' => $id]);
        return $this;
    }

    public function save()
    {
        if(is_null($this->id)){
            $this->insert();
        } else $this->update();
    }
}