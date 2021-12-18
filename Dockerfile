FROM ruby:2.7.5
ENV LANG C.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt update -qq && apt install -y nodejs yarn postgresql-client

RUN mkdir /masamune
WORKDIR /masamune
COPY .ruby-version /masamune/.ruby-version
COPY Gemfile /masamune/Gemfile
COPY Gemfile.lock /masamune/Gemfile.lock
RUN gem update bundler
RUN bundle install
COPY . /masamune

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
