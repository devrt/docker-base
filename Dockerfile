# Base image for devRT
# - enable universe and restricted repository
# - fix initctl behavior 
# - install chef

FROM ubuntu:raring
MAINTAINER Yosuke Matsusaka "yosuke.matsusaka@gmail.com"

# Enable universe and restricted repository
RUN echo "deb http://archive.ubuntu.com/ubuntu raring main universe restricted" > /etc/apt/sources.list

# Hack for initctl                                    
# See: https://github.com/dotcloud/docker/issues/1024 
RUN dpkg-divert --local --rename --add /sbin/initctl 
RUN ln -sf /bin/true /sbin/initctl

# Install chef and berkshelf
# Thanks to: http://tech.paulcz.net/2013/09/creating-immutable-servers-with-chef-and-docker-dot-io.html
RUN apt-get -y update
RUN apt-get -y install curl build-essential libxml2-dev libxslt-dev git
RUN curl -L https://www.opscode.com/chef/install.sh | bash
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN /opt/chef/embedded/bin/gem install berkshelf
