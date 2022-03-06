console:
	docker-compose run --rm web rails console
bash:
	docker-compose exec web bash
up:
	docker-compose up -d
down:
	docker-compose down
restart:
	docker-compose restart
dbm:
	docker-compose run --rm web rails db:migrate
