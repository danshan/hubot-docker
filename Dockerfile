FROM node:7
MAINTAINER Dan <i@shanhh.com>

# Usual update / upgrade
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get install -y redis-server git-core

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install coffee-script, hubot
RUN npm install -g yo generator-hubot coffee-script

# Working enviroment
ENV BOTDIR /opt/data/bot
RUN mkdir -p ${BOTDIR}
ENV HUBOT_USER hubot
RUN useradd ${HUBOT_USER} -m
RUN chown -R ${HUBOT_USER} ${BOTDIR}

# Install Hubot
USER ${HUBOT_USER}
WORKDIR ${BOTDIR}
RUN yo hubot --name="Hubot" --defaults

# Install slack adapter
RUN npm install hubot-slack --save
RUN npm install hubot-reload-scripts --save
RUN npm install hubot-proxy-loader --save

ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/danshan/hubot-docker"
