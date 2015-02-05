#!/bin/bash

service unicorn stop

cd /home/rails/

git pull

sh /home/rails/bin/rake db:migrate RAILS_ENV=production

sh /home/rails/bin/rake assets:precompile RAILS_ENV=production

sh /home/rails/bin/bundle install

service unicorn start

exit