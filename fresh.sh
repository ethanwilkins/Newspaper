#!/bin/bash

service unicorn stop

cd /home/rails/

git pull

/home/rails/bin/rake db:migrate RAILS_ENV=production

/home/rails/bin/rake assets:precompile RAILS_ENV=production

/home/rails/bin/bundle install

service unicorn start

exit