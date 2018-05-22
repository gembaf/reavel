#!/bin/sh
cd /srv/www/reavel/current
RAILS_ENV=production bundle exec rake unicorn:start
