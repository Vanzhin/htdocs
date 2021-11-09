<div id="main">
    <div class="post_title"><h2>Каталог</h2></div>
    <div class="gallery" id="gallery">
        <?php foreach($catalog as $item):?>
            <div class="gallery_item">
                <a rel="gallery" class="photo" href="/product/card/?id=<?=$item['id']?>"><img alt="<?=$item['title']?>" src="gallery_img/small/<?=$item['title']?>" width="150" height="100" /></a>
                <h3><?=$item['name']?></h3>
                <h4>Цена: <?=$item['price']?></h4>
                <h4>Понравилось: <span id="<?=$item['id']?>"><?=$item['likes']?></span> покупателям</h4>
                <span class="like" data-id="<?=$item['id']?>">Мне нравится</span>
                <button class = "buy" type="submit" name="buy" buy-id="<?=$item['id']?>" value="<?=$item['id']?>"><?=$buyText?></button>
            </div>
        <?php endforeach; ?>

    </div>
    <div class="button" id="more">
        <a href="/product/catalog/?page=<?=$page?>">еще</a>
    </div>
</div>
<script>
/*поскольку карточки подгружаются по две за раз, остальные подгружаются по клику, надо навешивать события
  на вновь отрисованные элементы: логика такая - как только отрисовываются еще карточки я навешиваю на них атрибут buy
  , затем при повторном вызове функции buyClick, слушатель навешивается только на те, у которых атрибута нет*/
function buyClick(){
        const buttonsBuy = document.querySelectorAll('.buy');
        buttonsBuy.forEach((elem)=>{
            if(!elem.hasAttribute('buy')){
                elem.setAttribute('buy', '1');
                elem.addEventListener('click',() =>{
                    const id = elem.getAttribute('buy-id');

                    (async () =>{
                            const response = await fetch("/cart/add/?id=" + id);
                            const answer = await response.json();
                            console.log(answer);
                            if (answer.status === 'ok'){
                                document.getElementById('cart_num').innerHTML = "( " + answer.total + " )";
                            }
                        }
                    )()
                })
            }

        });

    }
    const more = document.getElementById('more');
    more.addEventListener('click',(e) =>{
        e.preventDefault();
        const itemsCount = document.getElementsByClassName('gallery_item').length;
            (
                async () =>{
                    const response = await fetch("/product/catalog/?showMore=" +  itemsCount);
                    const answer = await response.text();
                    const a = document.getElementsByClassName('gallery')[0];
                    a.insertAdjacentHTML('beforeend', answer);
                    buyClick();
                }
            )()
        });


 buyClick();

</script>


