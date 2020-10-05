FROM ruby:2.7.1
ENV LANG C.UTF-8

ENV NODE_PATH /usr/lib/nodejs:/usr/share/nodejs

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt update -qq && apt install -y nodejs yarnpkg postgresql-client
RUN ln -s /usr/bin/yarnpkg /usr/bin/yarn

RUN mkdir /masamune
WORKDIR /masamune
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
