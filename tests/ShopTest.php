<?php

namespace app\tests;

use PHPUnit\Framework\TestCase;

class ShopTest extends TestCase
{

    public function testAdd()
    {
        $x = 2;
        $y = 3;
        $this->assertEquals(5, $x + $y);
    }
}