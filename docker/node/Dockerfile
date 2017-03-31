FROM node:7.7.3

RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 0.21.3
ENV PATH $PATH:`yarn global bin`

RUN apt-get update \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY \
  frontend/package.json \
  frontend/yarn.lock \
  /app/
RUN yarn install

COPY frontend/. /app
