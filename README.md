# И все же было больно.

Актуальная версия игры https://github.com/LencoDigitexer/and-yet-it-hurt/releases/tag/2.0 <br>
<a href="https://github.com/LencoDigitexer/and-yet-it-hurt/releases/download/2.0/and_yet_it_hurt.zip" download>
<img src="https://fxsa.me/data/attachments/23/23571-979e64e416f0e89b27c736cfe6c94209.jpg">
</a>

<img src="https://downloader.disk.yandex.ru/preview/fac2ddfae0f0514a660022f48c0b7cb85c987a4ae348ed4f81070e3b7258d861/5e78d463/pzIpjFen8qRb8QRB4VsDuWP2O2t4wrHDmpAgb4bDGoGmihlbglv72rS11oVJU-wgrBgfh--Cs7rZA5yXwIQNlg==?uid=0&filename=2020-03-23_14-21-01.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&tknv=v2&owner_uid=937437652&size=2048x2048">

Исходный код игры для блокнота с переводом текста на русском языке.
В процессе перевода...
Основная проблема перевода скриптов lua - кодировка:
> github не умеет "правильно" отображать windows1251, вместо этого видим кракозябры, но умеет в UTF-8

> интерпритатор скриптов Lua - LOVE ругается на UTF-8, но требует windows1251

Поэтому для запуска исходников, надо переконвертировать все скрипты в windows1251.

Основная, тоже немаловажная, проблема - трудности перевода.
> Дело в том, что в английском языке глаголы не имеют пола, а в русском - да. Поэтому пришлось оставить только женских персонажей в игру(вы все прекрасно понимаете почему), благо, я нашел имена девушек, которые даже в русском виде не имеют склонений (Кроу, Бэтти), но если пользователь захочет ввести свое имя, то оно останется неизменным, хотя в английском все проще - просто добавить окончание 's.

* [Играть в игру на английском языке](https://sheepolution.itch.io/and-yet-it-hurt)
* [Посмотреть трэйлер на английском языке](https://www.youtube.com/watch?v=qcdMVoE4mJM)
* [Read about how the game was made](https://sheepolution.com/blog/gamedev/how-i-made-a-game-played-in-notepad/)
* [Узнать, как я сделал эту игру](https://habr.com/ru/company/playgendary/blog/488222/)
