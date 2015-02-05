#!/bin/bash

service unicorn stop

(
	cd /home/rails/
	git pull
	rake db:migrate RAILS_ENV=production
	rake assets:precompile RAILS_ENV=production
	bundle install
)

service unicorn start

exit