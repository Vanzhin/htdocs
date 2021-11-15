<?php

namespace app\engine;
use app\traits\TSingleton;

class Db
{
    public $config = [
        'driver' => 'mysql',
        'host' => 'localhost:3306',
        'login' => 'test_user',
        'password' => '1234',
        'database' => 'shop',
        'charset' => 'utf8',
    ];
    private $connection = null;


    use TSingleton;

    private function getConnection()
    {
        if (is_null($this->connection)){
            $this->connection = new \PDO(
                $this->prepareDsnString(),
                $this->config['login'],
                $this->config['password']);
                $this->connection->setAttribute(\PDO::ATTR_DEFAULT_FETCH_MODE, \PDO::FETCH_ASSOC);
        }
        return $this->connection;
    }


    private function prepareDsnString()
    {
        return sprintf("%s:host=%s;dbname=%s;charset=%s",
            $this->config['driver'],
            $this->config['host'],
            $this->config['database'],
            $this->config['charset'],
        );
    }
    private function query($sql, $params)
    {
        $stmt = $this->getConnection()->prepare($sql);
        $stmt->execute($params);
        return $stmt;

    }

    public function queryLimit($sql, $rowFrom, $quantity)
    {
        $stmt = $this->getConnection()->prepare($sql);
        $stmt->bindValue(':rowFrom', $rowFrom, \PDO::PARAM_INT);
        $stmt->bindValue(':quantity', $quantity, \PDO::PARAM_INT);
        $stmt->execute();
        return $stmt;

    }


    public function lastInsertId(): string
    {
        return $this->getConnection()->lastInsertId();
    }

    public function queryOneResult($sql, $params = [])
    {
        return $this->query($sql, $params)->fetch();
    }

    public function queryOneObject($sql, $params, $class)
    {
        $stmt = $this->query($sql, $params);
        $stmt->setFetchMode(\PDO::FETCH_CLASS | \PDO::FETCH_PROPS_LATE, $class);
        return $stmt->fetch();
    }

    public function queryAll($sql, $params = [])
    {
        return $this->query($sql, $params)->fetchAll();
    }


    public function execute($sql, $params = [])
    {
        return $this->query($sql, $params)->rowCount();
    }


}