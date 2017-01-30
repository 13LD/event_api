FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /event_api
WORKDIR /event_api
ADD Gemfile /event_api/Gemfile
ADD Gemfile.lock /event_api/Gemfile.lock
RUN bundle install
ADD . /event_api