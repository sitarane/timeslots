console:
	docker-compose run --rm web rails console --sandbox
bash:
	docker-compose run --rm web bash
web:
	docker-compose up -d
down:
	docker-compose down
restart:
	docker-compose restart
dbm:
	docker-compose run --rm web rails db:migrate
bundle:
	docker-compose run --rm web bundle install
tst:
	docker-compose run --rm web rails test
routes:
	docker-compose run --rm web rails routes
logs:
	docker-compose logs -f
