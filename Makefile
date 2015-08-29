IMAGE_NAME = peba_web

startup:
	rake sunspot:solr:run &
	bundle exec guard -i -P bundler rails

setup:
	docker exec -it $(IMAGE_NAME) rake db:setup
	docker exec -it $(IMAGE_NAME) rake db:migrate
	docker exec -it $(IMAGE_NAME) rake crawler:run
