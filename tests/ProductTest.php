<?php

namespace app\tests;


use app\models\Product;
use PHPUnit\Framework\TestCase;

class ProductTest extends TestCase
{
    public function testProduct()
    {
        $name = "ноутбук";
        $product = new Product($name);
        $this->assertEquals($name, $product->name);

    }
}