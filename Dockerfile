FROM ruby:2.5.3-alpine3.8

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                sqlite-dev \
                                nodejs \
                                tzdata

ENV APP_PATH /usr/src/app

# Different layer for gems installation
WORKDIR $APP_PATH
ADD Gemfile $APP_PATH
ADD Gemfile.lock $APP_PATH
RUN bundle install

# Copy the application into the container
COPY . $APP_PATH

CMD ["bundle", "exec", "rails", "server"]
