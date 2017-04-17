# README

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

# Congratulations!
$ curl "http://localhost:3000"

# Update gems
$ docker-compose run --rm puma bundle install

# Create sample date
$ docker-compose run --rm puma bundle exec rake db:seed

# Create, Rename file
$ docker-compose restart puma
$ docker-compose restart node
```
