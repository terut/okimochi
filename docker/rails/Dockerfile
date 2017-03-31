FROM ruby:2.4.0

RUN apt-get update \
  && apt-get install --yes --no-install-recommends mysql-client \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY \
  Gemfile \
  Gemfile.lock \
  /app/
RUN bundle install --jobs=4 --path=/bundle \
  && mkdir -p /app/tmp/cache \
  && mkdir -p /app/tmp/pids \
  && mkdir -p /app/tmp/sockets

COPY . /app
