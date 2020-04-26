FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/src/app
VOLUME /data
VOLUME /export

RUN apt-get update && apt-get install -y make  g++  libx11-dev  libtbb-dev imagemagick libmagickcore-dev libmagickwand-dev libmagic-dev git && apt-get clean

COPY . /usr/src/app/
RUN mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.backup
RUN cp /usr/src/app/config/policy.xml /etc/ImageMagick-6/policy.xml
RUN cd /usr/src/app && git submodule init && git submodule update
RUN cd /usr/src/app && make
ENTRYPOINT ["/usr/src/app/panorama"]