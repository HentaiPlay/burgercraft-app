###################################
# Велосипеды для удобства =))
###################################

include .env
$(eval dev:;@:)

PURPLE_COLOR=\033[1;35m
NO_COLOR=\033[0m

# Запуск приложения (с полной сборкой по умолчанию в --detach режиме)
# make run dev отключает --detach (для тестирования)
run:
	@printf '\n%8s \xF0\x9F\x9A\x80 Запуск приложения... \n\n'
	@printf '%8s \xF0\x9F\x94\xA7 Собираем контейнеры... \n\n'
ifeq (dev, $(filter dev, $(MAKECMDGOALS)))
	@printf '%8s \xF0\x9F\x91\x80 Включен режим просмотра логов \n\n'
	@docker compose up --build
else
	@docker compose up --build -d
	@printf '\n%8s \xF0\x9F\x94\x97 (ctrl + click): http://${APP_HOST} \n'
	@printf '\n%8s \xE2\x9C\x94 Готово! \n\n'
endif

# Остановка приложения (с удалением всех контейнеров и образов)
stop:
	@printf '\n%8s \xF0\x9F\x93\xA6 Удаляем образа и контейнеры... \n\n'
	@docker compose down --rmi all --volumes
	@printf '\n%8s \xE2\x9C\x94 Готово! \n\n'

# Выкидывает ссылку на веб морду БД и данные для авторизации и первого подключения
pgadmin:
	@printf '\n%8s \xF0\x9F\x94\x97 (ctrl + click): http://${PGADMIN_HOST} \n'
	@printf '\n%8s \xF0\x9F\x94\x90 ${PURPLE_COLOR} Авторизация: ${NO_COLOR} \n'
	@printf '\n%7s email: ${PGADMIN_DEFAULT_EMAIL}'
	@printf '\n%7s password: ${PGADMIN_DEFAULT_PASSWORD} \n'
	@printf '\n%8s \xF0\x9F\x94\x8C ${PURPLE_COLOR} Создание подключения (если при сборке в "Servers" не создано подключение): ${NO_COLOR} \n'
	@printf '\n%8s Имя/адрес сервера: postgres'
	@printf '\n%8s Имя пользователя: ${POSTGRES_USER}'
	@printf '\n%8s Пароль: ${POSTGRES_PASSWORD} \n\n'