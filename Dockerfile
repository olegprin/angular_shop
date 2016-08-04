FROM ruby:2.3.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install nodejs-legacy
RUN echo '{ "allow_root": true }' > /root/.bowerrc
RUN apt-get install -y npm

RUN npm install -g bower
RUN bower install --save angular-devise
RUN bower install --save ng-token-auth
RUN bower install angular-cookies
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp