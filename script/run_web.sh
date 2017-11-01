#!/bin/sh
echo "Starting migration"

bundle exec rake db:migrate
echo "Migration complete"

mkdir -p /var/log/nginx/healthd

echo "Starting web application"
bundle exec passenger start -p ${PORT:-80} --max-pool-size ${WEB_CONCURRENCY:-2} --min-instances ${WEB_CONCURRENCY:-2} --log-file=/dev/stdout
