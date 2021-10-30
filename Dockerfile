FROM ruby:3.0.1

RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main 12' > /etc/apt/sources.list.d/pgdg.list \
  && apt-get update \
  && apt-get install -y postgresql-client-12

RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && echo "Asia/Tokyo" > /etc/timezone

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]