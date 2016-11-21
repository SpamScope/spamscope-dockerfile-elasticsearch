FROM fmantuano/apache-storm
MAINTAINER Fedele Mantuano "mantuano.fedele@gmail.com"
ENV REFRESHED_AT="2016-11-21" \
    SPAMSCOPE_VER="master" \
    STORM_VER="1.0.2" \
    STREAMPARSE_VER="3.2.0" \
    TIKA_APP_JAR_VER="1.14"
ENV FAUP_PATH="/opt/faup-master" \
    LEIN_ROOT="yes" \
    SPAMSCOPE_PATH="/opt/spamscope" \
    STORM_PATH="/opt/apache-storm-${STORM_VER}" \
    WORKER_HEAP=1024
LABEL description="Spamscope: Advanced Spam Analysis - Debug" \
    spamscope_version=${SPAMSCOPE_VER} \
    storm_version=${STORM_VER} \
    streamparse_version=${STREAMPARSE_VER}
RUN apt-get -yqq update \
    && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
    && apt-get -yqq install \
        cmake \
        git \
        libffi-dev \
        libfuzzy-dev \
        libxml2-dev \
        libxslt1-dev \
        libyaml-dev \
        p7zip-full \
        python-dev \
        python-pip \
        unrar-free \
        unzip \
        zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN curl -o /opt/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
    && chmod 755 /opt/lein \
    && ln -s /opt/lein /usr/local/bin/lein \
    && lein version \
    && curl -o /opt/tika-app-${TIKA_APP_JAR_VER}.jar https://archive.apache.org/dist/tika/tika-app-${TIKA_APP_JAR_VER}.jar \
    && sed -i "/worker.heap.memory.mb/cworker.heap.memory.mb: ${WORKER_HEAP}" $STORM_PATH/conf/storm.yaml
RUN git clone https://github.com/stricaud/faup.git ${FAUP_PATH} \
    && mkdir -p $FAUP_PATH/build \
    && cd $FAUP_PATH/build \
    && cmake .. \
    && make \
    && make install \
    && echo '/usr/local/lib' | tee -a /etc/ld.so.conf.d/faup.conf \
    && ldconfig \
    && cd $FAUP_PATH/src/lib/bindings/python \
    && python setup.py install
RUN git clone https://github.com/SpamScope/spamscope.git --branch ${SPAMSCOPE_VER} ${SPAMSCOPE_PATH} \
    && pip install --upgrade pip \
    && pip install -r $SPAMSCOPE_PATH/requirements.txt \
    && mkdir -p /var/log/spamscope \
    && mkdir -p /etc/spamscope
COPY my_init.d/topology_submit.sh /opt/
COPY my_init.d/99_template_submit.sh /etc/my_init.d/
WORKDIR $SPAMSCOPE_PATH
