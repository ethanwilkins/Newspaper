#!/bin/sh

ssh root@elheroe.net 'service unicorn stop && cd /home/rails && git pull && export PATH=$PATH:/usr/local/rvm/rubies/ruby-2.1.5/bin && /home/rails/bin/bundle install && export RAILS_DB_PWD="$RAILS_DB_PWD" && /home/rails/bin/rake db:migrate RAILS_ENV=production && /home/rails/bin/rake assets:precompile RAILS_ENV=production && service unicorn start'