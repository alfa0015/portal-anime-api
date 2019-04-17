FROM ruby:2.5.5-alpine3.9
RUN apk add --update build-base postgresql-dev tzdata git
RUN gem install rails -v '5.2.1'
WORKDIR /app
ADD Gemfile /app/
ADD Gemfile.lock /app/
RUN bundle install
ADD . .
CMD ["puma"]
EXPOSE 3000