FROM ruby:2.4.0

WORKDIR /app

RUN mkdir -p /app/tmp/cache \
  && mkdir -p /app/tmp/pids \
  && mkdir -p /app/tmp/sockets

RUN apt-get update \
  && apt-get install --yes --no-install-recommends mysql-client \
  && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH /bundle
