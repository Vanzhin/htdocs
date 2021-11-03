<div id="main">
    <div class="post_title"><h2>Корзина</h2></div>
    <div class="gallery_item">
        <?=isset($basketEmpty) ? $basketEmpty : $message;?>
        <p><?=$orderMessage;?></p>
        <?php foreach($basketData as $good):?>
            <div class="feedback-item feedback">
                <a rel="gallery" class="photo" href="/product/card/?id=<?=$good['product_id']?>"><img alt="<?=$good['imageName']?>" src="/gallery_img/small/<?=$good['imageName']?>" width="50" height="50"/></a>
                <p><?=$good['name']?></p>
                <p><?=$good['quantity']?></p>
                <p><?=$good['price']?></p>
                <P><?=$good['totalPrice']?></P>
                <a href="?action=delete&id=<?=$good['product_id']?>">Удалить</a>
            </div>
        <?php endforeach; ?>
        <div><?=isset($basketEmpty) ? "" : "Итого: " . $basketPrice;?></div>
    </div>
    <div class="gallery_item" style="display: <?=isset($basketEmpty) ? "none" : "flex"; ?>">
        оформление заказа
        <form method="post" class="feedback-form" action="?action=order">
            <label for="name">Ваше имя</label><input type="text" name="name" id="name" value="">
            <label for="tel">Ваш телефон</label><input type="tel" id="tel" name="tel" value="">
            <label for="comment">Ваш комментарий</label><textarea name="comment" id="comment" rows="5" cols="33"></textarea>
            <input type="submit" value="Оформить заказ">
        </form>
    </div>
</div>
