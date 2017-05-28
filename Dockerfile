FROM fmantuano/spamscope-root:develop
MAINTAINER Fedele Mantuano "mantuano.fedele@gmail.com"
RUN apt-get -yqq update \
    && apt-get -yqq --no-install-recommends install python-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --ignore-installed elasticsearch-curator && mkdir -p /opt/curator
COPY curator/*.yml /opt/curator/
COPY curator/daily_elk_maintanence.sh /etc/cron.daily/
COPY my_init.d/*.sh /etc/my_init.d/
