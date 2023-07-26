### Пошаговая инструкция запуска ###

##### _Команды для первого запуска:_ #####
* `sudo apt install make` - для удобства используется make _(поэтому нужно предварительно установить)_
* `git submodule update --init` - установка сабмодулей _(frontend и backend)_
* `cp .example.env .env` - установка environment окружения _(для первого запуска можно и не менять, но лучше убедиться что используемые порты не заняты)_
* `sudo make run` - запуск приложения _(запускает docker compose up --build --detach c ui индикацией процессов)_
<br>

##### _Все команды:_ #####
* `sudo make run dev` - запуск в режиме дебага _(тот же запуск, но без --detach, для просмотра логов контейнеров)_
* `sudo make stop` - остановка приложения с удалением всех созданных образов и контейнеров _(запускает docker-compose down --rmi all c ui индикацией процессов)_
* `sudo make pgadmin` - команда предоставляющая ссылку и данные для авторизации в админ панель БД _(доступна только в production режиме)_

### О проекте ###
Заполню позже

### Карта проекта ###
Заполню позже