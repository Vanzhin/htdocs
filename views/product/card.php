<div id="main">
    <div class="post_title"><h2><?=$product->name?></h2></div>
    <div class="gallery_item">
        <img alt="<?=$product->name?>" src="gallery_img/big/<?=$product->title?>"/>
        <h3><?=$product->name?></h3>
        <h3><?=$product->description?></h3>
        <h4>Цена: <?=$product->price?></h4>
        <p>Понравилось: <?=$product->likes?> покупателям</p>
        <form action="" method="POST">
            <button type="submit" name="buy" value="<?=$product->id?>">Купить</button>
        </form>
    </div>
</div>
