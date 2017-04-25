FROM fmantuano/spamscope-root:1.4.8
MAINTAINER Fedele Mantuano "mantuano.fedele@gmail.com"
ENV REFRESHED_AT="2017-04-25"
RUN apt-get -yqq update \
    && apt-get -yqq --no-install-recommends install python-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --ignore-installed elasticsearch-curator && mkdir -p /opt/curator
COPY curator/*.yml /opt/curator/
COPY curator/daily_elk_maintanence.sh /etc/cron.daily/
COPY my_init.d/*.sh /etc/my_init.d/
