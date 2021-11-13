<div id="main">
    <div class="post_title"><h2><?=$product['name']?></h2></div>
    <div class="gallery_item">
        <img alt="<?=$product['name']?>" src="/gallery_img/big/<?=$product['title']?>"/>
        <h3><?=$product['name']?></h3>
        <h3><?=$product['description']?></h3>
        <h4>Цена: <?=$product['price']?></h4>
        <p>Понравилось: <?=$product['likes']?> покупателям</p>
        <button class = "buy" type="submit" name="buy" buy-id="<?=$product['id']?>"><?=$buyText?></button>
        <div class="feedback" id="feedback">
            <h2>Отзывы о <?=$product['name']?></h2>
            <hr>
            <?php if ($feedbackData):?>
            <?php foreach($feedbackData as $feedback):?>
                <div class="feedback-item">
                    <h4><?=$feedback['user_name']?></h4>
                    <h5><?=$feedback['created_at']?></h5>
                    <p><?=$feedback['feedback']?></p>
                    <?php if ($feedback['user_id'] === $user_id):?>
                    <a href="/feedback/del/?id=<?=$feedback['id']?>">Х</a>
                    <button class="button feed_edit"  feed-id ="<?=$feedback['id']?>">правка</button>
                    <?php endif; ?>
                </div>
                <hr>
            <?php endforeach; ?>
            <?php else: ?>
                <p>Отзывов пока нет</p>
            <?php endif; ?>
            <?php if ($isAuth):?>
            <p>Оставить отзыв</p>
            <div class="feedback-send">
                <form method="post" class="feedback-form" action="/feedback/add/?prod_id=<?=$product['id']?>">
                    <input id="feed_id" type="text" name="id"  style="display:none">
                    <textarea id = "feed_text" name="user_feedback" rows="5" cols="33"><?=$row['feedback']?></textarea>
                    <input type="submit" value="<?=$buttonText?> отзыв" id="add_feedback">
                </form>
            </div>
            <?php else: ?>
                <p>Зарегистрируйтесь и оставьте отзыв</p>
            <?php endif; ?>
        </div>
    </div>
</div>
<script>

        const buttonsBuy = document.querySelectorAll('.buy');
        buttonsBuy.forEach((elem)=>{
                elem.addEventListener('click',() =>{
                    const id = elem.getAttribute('buy-id');

                    (async () =>{
                            const response = await fetch("/cart/add/?id=" + id);
                            const answer = await response.json();
                            if (answer.status === 'ok'){
                                document.getElementById('cart_num').innerHTML = "( " + answer.total + " )";
                            }
                        }
                    )()
                })


        });

        const buttonsFeedEdit = document.querySelectorAll('.feed_edit');
        buttonsFeedEdit.forEach((elem)=>{
            elem.addEventListener('click',() =>{
                const id = elem.getAttribute('feed-id');

                (
                    async () =>{
                        const response = await fetch("/feedback/edit/?id=" + id);
                        const answer = await response.json();
                        document.getElementById('feed_text').innerHTML = answer.feedbackText;
                        document.getElementById('add_feedback').value = answer.buttonText;
                        document.getElementById('feed_id').value = answer.feedId;


                    }
                )()
            })


        });

</script>