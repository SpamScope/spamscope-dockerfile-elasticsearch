FROM fmantuano/spamscope-deps

MAINTAINER Fedele Mantuano "mantuano.fedele@gmail.com"

# environment variables
ARG SPAMSCOPE_VER="develop"

ENV SPAMASSASSIN_ENABLED="True" \
    SPAMSCOPE_CONF_FILE="/etc/spamscope/spamscope.yml" \
    SPAMSCOPE_PATH="/opt/spamscope" \
    THUG_ENABLED="True"

# labels
LABEL description="Spamscope: Advanced Spam Analysis" \
    spamscope_version=${SPAMSCOPE_VER}

# install SpamScope
RUN set -ex; \
    mkdir -p "/var/log/spamscope" "/etc/spamscope" "/opt/curator"; \
    git clone -b ${SPAMSCOPE_VER} --single-branch https://github.com/SpamScope/spamscope.git ${SPAMSCOPE_PATH}; \
    cd $SPAMSCOPE_PATH; \
    pip install -r requirements_optional.txt; \
    python setup.py install; \
    sparse jar -s; \
    pip install elasticsearch-curator ;\
    pip install -U thug;

COPY curator/*.yml /opt/curator/
COPY curator/00daily-elastic-maintenance /etc/cron.daily/
COPY my_init.d/*.sh /etc/my_init.d/
    
WORKDIR ${SPAMSCOPE_PATH}
