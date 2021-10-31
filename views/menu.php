<?php if($allow): ?>
    <div class="hello">Добро пожаловать, <?=$login?>&nbsp;
        <form class="bye" method="post">
            <button type="submit" name="logout">Выйти</button>
        </form>
    </div>
<?php else: ?>
    <div class="error">
        <?=$logMessage?>
    </div>
    <form action="/?c=auth&a=login" method="post">
        <input type="text" name="login">
        <input type="password" name="pass">
        <label class="text" for="save"> Запомнить меня</label><input id="save" type="checkbox" name="save">
        <input type="submit" value="вход" name="submit">
        <a href="/?c=auth&a=reg" style="display: <?= strpos($_SERVER['REQUEST_URI'], 'registration') ? 'none' : 'inline-block'; ?>" class="button">Зарегистрироваться</a>
    </form>
<?php endif; ?>
<a href="/?c=index&a=index" class="main_menu">Главная</a>
<a href="/?c=product&a=catalog" class="main_menu">Каталог</a>
<a href="/?c=feedback&a=feeds" class="main_menu">Отзывы</a>
<a href="#" class="main_menu">Корзина <?= ($grandTotal['total'] > 0) ? "( " . $grandTotal['total'] . " )" : "";?></a></a>
