FROM ruby:2.5

WORKDIR /var/app
ADD Gemfile Gemfile.lock /var/app/

RUN gem install bundler
RUN bundle install

ADD . /var/app