<div id="main">
    <div class="post_title"><h2>Админка</h2></div>
    <div class="gallery_item">
        <p>Заказы магазина</p>
        <?=$message?>
        <?php foreach($ordersData as $order):?>
            <div class="feedback-item feedback">
                <p><?=$order['order_id']?></p>
                <p><?=$order['grandTotal']?></p>
                <p><?=$order['created_at']?></p>
                <P><?=$order['status']?></P>
                <P><?=$order['name']?></P>
                <P><?=$order['tel']?></P>
                <P><?=$order['comment']?></P>
            </div>
            <div>
                <a href="/admin/del/?id=<?=$order['order_id']?>">Удалить</a>
                <a href="/admin/view/?id=<?=$order['order_id']?>">Подробнее</a>
                <form action="/admin/status/?id=<?=$order['order_id']?>" method="post">
                    <input type="submit" value="Изменить статус на">
                    <select name="status">
                        <?php foreach($enumArr as $key => $item):?>
<!--                        делаю так, чтобы статус заказ можно было изменить только по логической цепочке т. е. сначала active->handle->shipped->delivered-->
                            <?php if(array_keys($enumArr, $order['status'], true)[0] <= $key): ?>
                            <option id = "<?=$key?>" value="<?=$item?>" <?php if($order['status'] == $item) echo 'selected';?>><?=$item?></option>
                            <?php endif; ?>
                        <?php endforeach; ?>

                    </select>
                </form>
            </div>
        <?php endforeach; ?>
    </div>
</div>
