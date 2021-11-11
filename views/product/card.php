<div id="main">
    <div class="post_title"><h2><?=$product['name']?></h2></div>
    <div class="gallery_item">
        <img alt="<?=$product['name']?>" src="/gallery_img/big/<?=$product['title']?>"/>
        <h3><?=$product['name']?></h3>
        <h3><?=$product['description']?></h3>
        <h4>Цена: <?=$product['price']?></h4>
        <p>Понравилось: <?=$product['likes']?> покупателям</p>
        <button class = "buy" type="submit" name="buy" buy-id="<?=$product['id']?>"><?=$buyText?></button>

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
                            console.log(answer);
                            if (answer.status === 'ok'){
                                document.getElementById('cart_num').innerHTML = "( " + answer.total + " )";
                            }
                        }
                    )()
                })


        });

</script>