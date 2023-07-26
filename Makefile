###################################
# Велосипеды для удобства =))
###################################

include .env
$(eval dev:;@:)

# Запуск приложения (с полной сборкой по умолчанию в --detach режиме)
# make run dev отключает --detach (для тестирования)
run:
	@printf '\n%5s \xF0\x9F\x9A\x80 Запуск приложения... \n\n'
ifeq (dev, $(filter dev, $(MAKECMDGOALS)))
	@printf '\n%5s \xE2\x99\xBF Поехали дебажить... \n\n'
	@docker-compose up --build
else 
	@docker-compose up --build -d
	@printf '\n%5s \xE2\x9C\x94 Готово! \n\n'
endif

# Остановка приложения (с удалением всех контейнеров и образов)
stop:
	@printf '\n%5s \xF0\x9F\x93\xA6 Удаляем образа и контейнеры... \n\n'
	@docker-compose down --rmi all
	@printf '\n%5s \xE2\x9C\x94 Готово! \n\n'

# Выкидывает ссылку на веб морду БД и данные для авторизации (ссылка будет доступна только в прод режиме)
pgadmin:
	@printf '\n%8s \xF0\x9F\x94\x97 link (ctrl + click): http://localhost:${PGADMIN_PORT} \n'
	@printf '\n%8s \xF0\x9F\x93\xA8 email: ${PGADMIN_DEFAULT_EMAIL} \n'
	@printf '\n%8s \xF0\x9F\x94\x90 password: ${PGADMIN_DEFAULT_PASSWORD} \n\n'