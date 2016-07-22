#
# Originally from https://github.com/docker-library/openjdk/blob/master/8-jdk/Dockerfile
#

FROM buildpack-deps:jessie-scm

MAINTAINER stevej@buoyant.io

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-i386
ENV JAVA_VERSION 8u91
ENV JAVA_DEBIAN_VERSION 8u91-b14-1~bpo8+1

# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20140324

RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
RUN set -x \
    apt-get update \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y install libc6:i386 \
    && apt-get update \
    && apt-get install --fix-missing -y --no-install-recommends \
        openjdk-8-jdk-headless:i386="$JAVA_DEBIAN_VERSION" \
        ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" \
    && update-java-alternatives --set java-1.8.0-openjdk-i386 \
    && /var/lib/dpkg/info/ca-certificates-java.postinst configure

