FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev
RUN apt-get clean

RUN useradd -ms /bin/bash rails
RUN usermod -a -G root rails

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "gem: --no-rdoc --no-ri" > /etc/gemrc

RUN mkdir /usr/src/backend-app
RUN mkdir /usr/src/bundle_cache

WORKDIR /usr/src/backend-app

RUN gem install bundler

ADD . /usr/src/backend-app

RUN chown -R rails:rails /usr/src

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh && \
    chown rails:rails /docker-entrypoint.sh

USER rails

ENV BUNDLE_PATH /usr/src/bundle_cache

EXPOSE 3000

CMD ["/docker-entrypoint.sh", "rails s -e production"]
