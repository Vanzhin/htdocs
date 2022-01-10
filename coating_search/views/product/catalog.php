<h2>Каталог</h2>
<?php foreach ($catalog as $item):?>
<div>
    <h3><a href="/?c=product&a=card&id=<?=$item['id']?>"><?=$item['name']?></a></h3>
    <p><?=$item['brand']?></p>
    <p><?=$item['catalog']?></p>
    <p><?=$item['description']?></p>
    <p><?=$item['binder']?></p>
    <?php if (is_null($item['pds_link'])):?>
    <p>ссылки нет</p>
    <?php else:?>
    <a href="<?=$item['pds_link']?>">ссылка</a>
    <?php endif;?>





</div>

<?php endforeach;?>
<div>
    <a href="/?c=product&a=catalog&page=<?=$page?>">еще</a>
</div>
