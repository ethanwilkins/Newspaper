#!/bin/bash

service unicorn stop

cd /home/rails/

git pull

sh /home/rails/rake db:migrate RAILS_ENV=production

sh /home/rails/rake assets:precompile RAILS_ENV=production

sh /home/rails/bundle install

service unicorn start

exit