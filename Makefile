IMAGE_NAME = peba_web

startup:
	elasticsearch &
	bundle exec guard -i -P bundler rails

setup:
	docker exec -it $(IMAGE_NAME) rake db:setup
	docker exec -it $(IMAGE_NAME) rake db:migrate
	docker exec -it $(IMAGE_NAME) rake crawler:run
