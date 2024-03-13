ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION

RUN apt-get update -qq && \
    apt-get install -y build-essential libvips bash bash-completion libffi-dev tzdata postgresql nodejs npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

RUN npm install -g yarn

WORKDIR /chat_app

ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    BUNDLE_WITHOUT="development"

COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./

RUN bundle install

COPY . .

RUN bundle exec bootsnap precompile app/ lib/
RUN bundle exec rails assets:precompile

ENTRYPOINT ["/chat_app/bin/docker-entrypoint"]
