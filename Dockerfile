FROM ruby:2.2-onbuild

RUN apt-get update && \
BUILD_PACKAGES="nano nodejs" && \
apt-get -y install $BUILD_PACKAGES

COPY . /usr/src/app
VOLUME ["/usr/src/app/assets", "/usr/src/app/output"]

ENTRYPOINT ["ruby", "/usr/src/app/watcher.rb"]