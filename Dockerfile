FROM debian:jessie
MAINTAINER Stanislav Stipl, stanislav.stipl@gmail.com

RUN apt-get update
RUN apt-get install -y mariadb-client stunnel rsync pgp

COPY run.sh /
COPY default_stunnel /etc/default/stunnel4

CMD /bin/sh /run.sh

