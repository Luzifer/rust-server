FROM debian

RUN set -ex \
 && dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y mailutils postfix curl wget file bzip2 gzip unzip bsdmainutils python util-linux tmux lib32gcc1 libstdc++6 libstdc++6:i386 \
 && adduser --disabled-password rustserver

ADD https://gameservermanagers.com/dl/rustserver /opt/rustserver
RUN set -ex \
 && chmod 755 /opt/rustserver

USER rustserver
WORKDIR /home/rustserver

ADD start.sh /opt/start.sh

VOLUME /home/rustserver

EXPOSE 28015/udp 28016
ENTRYPOINT ["/opt/start.sh"]
