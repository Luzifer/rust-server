FROM debian

ENV LC_ALL=C \
    LC_CTYPE=C \
    LANG=C

RUN set -ex \
 && dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y \
      bc \
      binutils \
      bsdmainutils \
      bzip2 \
      ca-certificates \
      curl \
      file \
      gzip \
      jq \
      lib32gcc1 \
      lib32z1 \
      libstdc++6 \
      libstdc++6:i386 \
      locales \
      mailutils \
      postfix \
      procps \
      python \
      tmux \
      unzip \
      util-linux \
      wget \
 && adduser --disabled-password rustserver \
 && echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen \
 && locale-gen \
 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

WORKDIR /tmp

ADD https://linuxgsm.com/dl/linuxgsm.sh /tmp/linuxgsm.sh
RUN set -ex \
 && chmod 0644 linuxgsm.sh \
 && su -c "bash linuxgsm.sh rustserver" rustserver \
 && chmod 0755 rustserver \
 && mv /tmp/rustserver /opt/rustserver

USER rustserver
WORKDIR /home/rustserver

ADD start.sh /opt/start.sh

VOLUME /home/rustserver

EXPOSE 28015/udp 28016
ENTRYPOINT ["/opt/start.sh"]
