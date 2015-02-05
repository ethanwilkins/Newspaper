#!/bin/bash

service unicorn stop

cd /home/rails/

git pull

export PATH=$PATH:/usr/local/rvm/rubies/ruby-2.1.5/bin

rake db:migrate RAILS_ENV=production

rake assets:precompile RAILS_ENV=production

bundle install

service unicorn start

exit