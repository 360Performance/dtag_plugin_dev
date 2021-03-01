FROM python:3.6-buster

RUN apt-get update
# install any native plugin dependencies here
#RUN apt install unixodbc-dev -y
#RUN pip install pyodbc
#RUN pip install ExasolDatabaseConnector


RUN mkdir /installers
COPY installers/Dynatrace-ActiveGate-Linux-x86-latest.sh /installers/
WORKDIR /installers
ENV DYNATRACE_ACTIVEGATE_SERVER_CONNECTION_TIMEOUT=15
COPY loop.sh /
RUN /bin/bash /loop.sh & /bin/sh Dynatrace-ActiveGate-Linux-x86-latest.sh

RUN mkdir /plugin_sdk
COPY installers/plugin-sdk-latest.zip /plugin_sdk
WORKDIR /plugin_sdk
RUN unzip plugin-sdk-latest.zip
RUN pip install $(ls -1 plugin_sdk*.whl)

RUN mkdir -p /var/lib/dynatrace/remotepluginmodule/agent/conf

RUN mkdir /plugin
WORKDIR /plugin
