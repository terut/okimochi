# README [![Build Status](https://travis-ci.org/terut/okimochi.svg?branch=master)](https://travis-ci.org/terut/okimochi)

## Development

You can use docker and docker-compose.

```sh
# Build and start docker container
$ cp docker-compose.example.yml docker-compose.yml
$ vim docker-compose.yml

  MAIL_HOSTNAME=xxxxx
  MAIL_USERNAME=xxxxx
  MAIL_PASSWORD=xxxxx

$ ./bin/build

# Run webpack --watch
$ docker-compose run --rm node yarn run dev
# Run app server
# You need to specify port temporary. ref: https://github.com/puma/puma/pull/1277#event-1064193856
$ docker-compose run --service-ports --rm puma bundle exec rails s -b 0.0.0.0 -p 3000

# Congratulations!
$ curl "http://localhost:3000"

# Update gems
$ docker-compose run --rm puma bundle install

# Clean up database
$ docker-compose run --rm puma bundle exec rake db:migrate:reset

# Create sample date
$ docker-compose run --rm puma bundle exec rake db:seed

# Create and rename file
$ docker-compose restart puma
$ docker-compose restart node

# Start and stop all container
$ docker-compose start
$ docker-compose stop

# Remove container
$ docker-compose rm
$ docker-compose rm --all
```
