<div id="main">
    <div class="post_title"><h2>Мои заказы</h2></div>
    <div class="gallery_item">
        <?php if($ordersData): ?>
            <?php foreach($ordersData as $order):?>
                <div class="feedback-item item">
                    <div class="center-flex">
                        <p>Заказ от: <?=$order['created_at']?></p>
                        <p>Статус: <?=$order['status']?></p>
                        <p>Последнее обновление: <br> <?=$order['updated_at']?></p>
                        <p>Сумма заказа: <?=$order['orderTotal']?></p>
                    </div>
                    <div class="center-flex">
                        <div>
                            <p>Фото </p>
                        </div>
                        <div>
                            <p>Название товара</p>
                        </div>
                        <div>
                            <p>Стоимость</p>
                        </div>
                        <div>
                            <p>Кол-во</p>
                        </div>
                        <div>
                            <p>Цена</p>
                        </div>
                    </div>
                    <?php foreach($userOrderData as $product):?>
                        <?php if($order['id'] === $product['order_id']):?>
                            <div class="center-flex">
                                <div>
                                    <a rel="gallery" class="photo" href="/product/card/?id=<?=$product['product_id']?>"><img alt="<?=$product['imageName']?>" src="/gallery_img/small/<?=$product['imageName']?>" width="50" height="50"/></a>
                                </div>
                                <div>
                                    <p><?=$product['name']?></p>
                                </div>
                                <div>
                                    <p><?=$product['price']?></p>
                                </div>
                                <div>
                                    <p><?=$product['quantity']?></p>
                                </div>
                                <div>
                                    <p><?=$product['totalPrice']?></p>
                                </div>
                            </div>
                        <?php endif; ?>
                    <?php endforeach; ?>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
        <p>Заказов пока нет</p>
        <?php endif; ?>

        <div>
            <p><?=isset($ordersData[0]) ? "Заказов на сумму: " . $totalPrice : '' ;?></p>
        </div>
    </div>
</div>
