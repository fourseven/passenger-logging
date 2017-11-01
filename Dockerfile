FROM ruby:2.4.2

RUN apt-get update -qq && \
    apt-get install -y build-essential cron nodejs npm nodejs-legacy postgresql-client s3cmd vim redis-tools && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /myapp

WORKDIR /tmp

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install --without development test -j4 -r5

ADD . /myapp
WORKDIR /myapp

# 12 factor setup
ENV PORT 80
ENV RAILS_SERVE_STATIC_FILES true
# This will break Passenger logging
# ENV RAILS_LOG_TO_STDOUT true

RUN npm install
RUN RAILS_ENV=production bundle exec rake assets:precompile

EXPOSE 80

ENTRYPOINT ["./script/entry.sh"]
CMD ./script/run_web.sh
