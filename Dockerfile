ARG SPAMSCOPE_VER="develop"
FROM fmantuano/spamscope-root:${SPAMSCOPE_VER}
MAINTAINER Fedele Mantuano "mantuano.fedele@gmail.com"
RUN pip install --ignore-installed elasticsearch-curator && mkdir -p /opt/curator
COPY curator/*.yml /opt/curator/
COPY curator/daily_elk_maintanence.sh /etc/cron.daily/
COPY my_init.d/*.sh /etc/my_init.d/
