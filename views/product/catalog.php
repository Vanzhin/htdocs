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
                <form action="/cart/add/?id=<?=$item['id']?>" method="POST">
                    <button class = "buy" type="submit" name="buy" data-id="<?=$item['id']?>" value="<?=$item['id']?>"><?=$buyText?></button>
                </form>
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
        const itemsCount = document.getElementsByClassName('gallery_item').length;
        e.preventDefault();
            (
                async () =>{
                    const response = await fetch("/product/catalog/?showMore=" +  itemsCount);
                    const answer = await response.text();
                    const a = document.getElementsByClassName('gallery')[0];
                    a.insertAdjacentHTML('beforeend', answer);
                }
            )()
        });

    //     const buttons = document.querySelectorAll('.buy');
    //     buttons.forEach((elem)=>{
    //     elem.addEventListener('click',() =>{
    //         const id = elem.getAttribute('data-id');
    //         (
    //             async () =>{
    //                 const response = await fetch("/product/add/?id=" + id);
    //                 const answer = await response.json();
    //                 document.getElementById(id).innerHTML = answer.likes;
    //             }
    //         )()
    //     })
    // });
</script>


