FROM ruby:2.5.1-alpine3.7

RUN apk add --no-cache build-base git

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle config --global frozen 1 \
    && bundle install \
    && mkdir /usr/src/app/config /usr/src/app/log

COPY bin ./bin/
COPY init.rb ./

ENV HECTOR_ROOT /usr/src/app
ENV LANG C.UTF-8

VOLUME /usr/src/app/config
EXPOSE 6767 6868

CMD ["/usr/local/bin/bundle", "exec", "hector", "daemon"]
