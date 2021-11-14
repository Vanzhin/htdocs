<?php if($allow): ?>
    <div class="hello">Добро пожаловать, <?=$login?>&nbsp;
        <form action="/auth/logout/" class="bye" method="post">
            <button type="submit" name="logout">Выйти</button>
        </form>
    </div>
<?php else: ?>
    <div class="error">
        <?=$logMessage?>
    </div>
    <form action="/auth/login/" method="post">
        <input type="text" name="login">
        <input type="password" name="pass">
        <label class="text" for="save"> Запомнить меня</label><input id="save" type="checkbox" name="save">
        <input type="submit" value="вход" name="submit">
        <a href="/auth/reg/" style="display: <?= strpos($_SERVER['REQUEST_URI'], 'registration') ? 'none' : 'inline-block'; ?>" class="button">Зарегистрироваться</a>
    </form>
<?php endif; ?>
<a href="/index/" class="main_menu">Главная</a>
<a href="/product/catalog/" class="main_menu">Каталог</a>
<a href="/feedback/feeds/" class="main_menu">Отзывы</a>
<a href="/cart/" class="main_menu">Корзина <span id="cart_num"><?= ($cartCount['total'] > 0) ? "( " . $cartCount['total'] . " )" : "";?></span></a></a>
<?php if($allow): ?>
<a href="/order/" class="main_menu">Мои Заказы</a>
<?php endif; ?>