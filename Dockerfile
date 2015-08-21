FROM library/ubuntu:14.04
MAINTAINER Rodrigo Fernandes <rodrigo.fernandes@tecnico.ulisboa.pt>

#
# Ubuntu with Oracle JRE 8
#

RUN locale-gen en_US en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV JRE_SEMVER 1.8.0_101
ENV JRE_VERSION 8u101
ENV JRE_BUILD b13
ENV JAVA_HOME /usr/lib/oracle-jre

# Download and install the required version of Oracle's JRE
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -y update && \
  apt-get -y install software-properties-common && \
  add-apt-repository -y ppa:git-core/ppa && \
  apt-get -y update && \
  apt-get -y install curl wget unzip nano git && \
  apt-get -y update && \
  apt-get -y upgrade && \
  wget --quiet --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JRE_VERSION-$JRE_BUILD/jre-$JRE_VERSION-linux-x64.tar.gz" && \
  tar -xvf "jre-$JRE_VERSION-linux-x64.tar.gz" && \
  rm -rf "jre-$JRE_VERSION-linux-x64.tar.gz" && \
  mv jre$JRE_SEMVER $JAVA_HOME && \
  update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 999999 && \
  update-alternatives --install /usr/bin/javaws java $JAVA_HOME/bin/javaws 999999 && \
  apt-get -y clean && \
  apt-get -y autoclean && \
  apt-get -y autoremove && \
  apt-get purge -y $(apt-cache search '~c' | awk '{ print $2 }') && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/apt && \
  rm -rf /tmp/*
