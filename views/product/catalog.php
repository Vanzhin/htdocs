<div id="main">
    <div class="post_title"><h2>Каталог</h2></div>
    <div class="gallery">
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
                }
            )()
        });
    //todo навесить события на вновь отрисованные элементы
    // function on(node, event, className, cb) {
    //     node.addEventListener(event, (e) => {
    //         if (!e.target.classList.contains(className)) {
    //             return false
    //         }
    //         cb(e)
    //     })
    // }
    // const body = document.querySelector('body')
    // on(body, 'click', 'buy', e => {
    //     const elem = e.target;
    //     console.log(elem);
    //     elem.addEventListener('click',() =>{
    //         const id = elem.getAttribute('buy-id');
    //
    //         (async () =>{
    //                 const response = await fetch("/cart/add/?id=" + id);
    //                 const answer = await response.json();
    //                 console.log(answer);
    //                 if (answer.status === 'ok'){
    //                     document.getElementById('cart_num').innerHTML = "( " + answer.total + " )";
    //                 }
    //             }
    //         )()
    //     })
    //
    // })

        const buttonsBuy = document.querySelectorAll('.buy');
        buttonsBuy.forEach((elem)=>{
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
    });

</script>


