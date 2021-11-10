<?php foreach($catalog as $item):?>
    <div class="gallery_item">
        <a rel="gallery" class="photo" href="/product/card/?id=<?=$item['id']?>"><img alt="<?=$item['title']?>" src="/gallery_img/small/<?=$item['title']?>" width="150" height="100" /></a>
        <h3><?=$item['name']?></h3>
        <h4>Цена: <?=$item['price']?></h4>
        <h4>Понравилось: <span id="like-<?=$item['id']?>"><?=$item['likes']?></span> покупателям</h4>
        <span class="like" data-id="<?=$item['id']?>">Мне нравится</span>
        <button class = "buy" type="submit" name="buy" buy-id="<?=$item['id']?>" value="<?=$item['id']?>"><?=$buyText?></button>
    </div>
<?php endforeach; ?>
