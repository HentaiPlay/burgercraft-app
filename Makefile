# Запуск приложения (с полной сборкой)
run:
	docker-compose up --build

# Остановка приложения (с удалением всех контейнеров и образов)
stop:
	docker-compose down --rmi all