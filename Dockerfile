FROM mhart/alpine-node:8.2
MAINTAINER Dan <i@shanhh.com>

# Install coffee-script, hubot
RUN npm install -g yo generator-hubot coffee-script

# Working enviroment
ENV BOTDIR /opt/data/bot
ENV HUBOT_USER hubot

RUN mkdir -p ${BOTDIR}
RUN useradd ${HUBOT_USER} -m
RUN chown -R ${HUBOT_USER} ${BOTDIR}

# Install Hubot
USER ${HUBOT_USER}
WORKDIR ${BOTDIR}
RUN yo hubot --name="Hubot" --defaults
