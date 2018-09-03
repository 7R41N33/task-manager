FROM ruby:2.5

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qqy && apt-get -qqyy install \
    nodejs \
    yarn

RUN mkdir -p /task_manager
WORKDIR /task_manager

COPY . /task_manager
COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 3

EXPOSE 3000

CMD bundle exec rails s -b '0.0.0.0' -p 3000
