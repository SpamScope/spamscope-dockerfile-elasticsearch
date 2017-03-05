FROM fmantuano/spamscope-root:1.4.4
MAINTAINER Fedele Mantuano "mantuano.fedele@gmail.com"
ENV REFRESHED_AT="2017-03-05"
RUN pip install elasticsearch-curator && mkdir -p /opt/curator
COPY curator/*.yml /opt/curator/
COPY curator/daily_elk_maintanence /etc/cron.daily/
COPY my_init.d/*.sh /etc/my_init.d/
