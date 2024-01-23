#######################################
# Сахар с UI индикациией процессов = ))
#######################################

include .env
$(eval dev:;@:)

ITALICS_FONT=\033[3m
RED_BACKGROUND=\033[41m
GREEN_COLOR=\033[92m
END_STYLE=\033[0m

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
	@printf '\n%8s \xF0\x9F\x94\x90 ${GREEN_COLOR} Авторизация:${END_STYLE} \n'
	@printf '\n%12s nickname: crafter98 ${ITALICS_FONT}(Роль "крафтера")${END_STYLE}'
	@printf '\n%12s nickname: admin ${ITALICS_FONT}(Роль "админа")${END_STYLE}'
	@printf '\n%12s password: ${PGADMIN_DEFAULT_PASSWORD} \n'
	@printf '\n%7s ${GREEN_COLOR} \xE2\x9C\x94 Готово! ${END_STYLE} \n\n'
endif

# Остановка приложения (с удалением всех контейнеров и образов)
stop:
	@printf '\n%8s \xF0\x9F\x93\xA6 Удаляем образа и контейнеры... \n\n'
	@docker compose down --rmi all --volumes
	@printf '\n%7s ${GREEN_COLOR} \xE2\x9C\x94 Готово! ${END_STYLE} \n\n'

# Выкидывает ссылку на веб морду БД и данные для авторизации и первого подключения
pgadmin:
	@printf '\n%8s \xF0\x9F\x94\x97 (ctrl + click): http://${PGADMIN_HOST} \n'
	@printf '\n%8s \xF0\x9F\x94\x90 ${GREEN_COLOR} Авторизация: ${END_STYLE} \n'
	@printf '\n%7s email: ${PGADMIN_DEFAULT_EMAIL}'
	@printf '\n%7s password: ${PGADMIN_DEFAULT_PASSWORD} \n'
	@printf '\n%7s ${ITALICS_FONT} ${RED_BACKGROUND}Если при сборке в "Servers" не создано подключение:${END_STYLE} \n'
	@printf '\n%8s \xF0\x9F\x94\x8C ${GREEN_COLOR}Создание подключения${END_STYLE} \n'
	@printf '\n%8s Имя/адрес сервера: postgres'
	@printf '\n%8s Имя пользователя: ${POSTGRES_USER}'
	@printf '\n%8s Пароль: ${POSTGRES_PASSWORD} \n\n'

#Выкидывает ссылку на документацию swagger api
swagger:
	@printf '\n%8s \xF0\x9F\x94\x97 (ctrl + click): http://${APP_HOST}/api/swagger \n\n'