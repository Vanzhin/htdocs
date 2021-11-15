<div id="main">
    <div class="post_title"><h2>Заказ id <?=$orderId?></h2></div>
    <div class="gallery_item">
        <p><?=$orderMessage;?></p>
        <?php foreach($orderData as $product):?>
            <div class="feedback-item feedback">
                <a rel="gallery" class="photo" href="/product/card/?id=<?=$product['product_id']?>"><img alt="<?=$product['imageName']?>" src="/gallery_img/small/<?=$product['imageName']?>" width="50" height="50"/></a>
                <p><?=$product['name']?></p>
                <p><?=$product['quantity']?></p>
                <p><?=$product['price']?></p>
                <P><?=$product['totalPrice']?></P>
<!--                <a href="?action=delete&id=--><?//=$product['product_id']?><!--&orderId=--><?//=$product['order_id']?><!--">Удалить</a>-->
            </div>
        <?php endforeach; ?>
        <div><?="Итого: " . $orderData[0]['grandTotal'];?></div>
    </div>
</div>
