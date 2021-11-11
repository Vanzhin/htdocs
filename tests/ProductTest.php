<?php

namespace app\tests;


use app\models\Product;
use PHPUnit\Framework\TestCase;

class ProductTest extends TestCase
{
    /**
     * @dataProvider providerProduct
     */

    public function testProduct($name, $description, $price, $catalog_id)
    {
        $product = new Product($name, $description, $price, $catalog_id);
        $this->assertEquals($name, $product->name);
        $this->assertEquals($description, $product->description);
        $this->assertEquals($price, $product->price);
        $this->assertEquals($catalog_id, $product->catalog_id);
        $this->assertObjectHasAttribute('propsFromDb',$product);
        $this->assertIsArray($product->propsFromDb);
        $product->__set('name', 'very good comp');
        $this->assertEquals('very good comp', $product->name);
        $entityName = $product->getTableName();
        $this->assertEquals('products',$entityName );





    }
    public function providerProduct()
    {
        return [
            ['comp', 'computer1', 1000, 1],
            ['book', 'notebook', 20000, 2]

        ];
    }
}