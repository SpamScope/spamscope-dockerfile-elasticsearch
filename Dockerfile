FROM fmantuano/apache-storm
MAINTAINER Fedele Mantuano "mantuano.fedele@gmail.com"
ENV REFRESHED_AT="2016-12-20" \
    SPAMSCOPE_VER="v1.3rc4" \
    STORM_VER="1.0.2" \
    STREAMPARSE_VER="3.3.0" \
    TIKA_APP_JAR_VER="1.14"
ENV FAUP_PATH="/opt/faup-master" \
    LEIN_ROOT="yes" \
    SPAMSCOPE_PATH="/opt/spamscope" \
    STORM_PATH="/opt/apache-storm-${STORM_VER}" \
    SPAMSCOPE_CONF_FILE="/etc/spamscope/spamscope.yml" \
    WORKER_HEAP=1024
LABEL description="Spamscope: Advanced Spam Analysis - Debug" \
    spamscope_version=${SPAMSCOPE_VER} \
    storm_version=${STORM_VER} \
    streamparse_version=${STREAMPARSE_VER}
RUN apt-get -yqq update \
    && apt-get -yqq upgrade -o Dpkg::Options::="--force-confold" \
    && apt-get -yqq --no-install-recommends install \
        bison \
        build-essential \
        cmake \
        dh-autoreconf \
        flex \
        git \
        graphviz \
        graphviz-dev \
        libboost-dev \
        libboost-python-dev \
        libboost-thread-dev \
        libc6 \
        libemu-dev \
        libemu2 \
        libffi-dev \
        libfreetype6-dev \
        libfuzzy-dev \
        libgraphviz-dev \
        libjpeg8-dev \
        liblcms2-dev \
        libssl-dev \
        libwebp-dev \
        libxml2-dev \
        libxslt1-dev \
        libyaml-dev \
        p7zip-full \
        pkg-config \
        python-dev \
        python-pip \
        python-setuptools \
        python-tk \
        tcl8.5-dev \
        tk8.5-dev \
        unrar-free \
        unzip \
        zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip install wheel \
    && curl -o /opt/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && chmod 755 /opt/lein && ln -s /opt/lein /usr/local/bin/lein && lein version \
    && curl -o /opt/tika-app-${TIKA_APP_JAR_VER}.jar https://archive.apache.org/dist/tika/tika-app-${TIKA_APP_JAR_VER}.jar \
    && sed -i "/worker.heap.memory.mb/cworker.heap.memory.mb: ${WORKER_HEAP}" $STORM_PATH/conf/storm.yaml \
    && git clone https://github.com/stricaud/faup.git ${FAUP_PATH} && mkdir -p $FAUP_PATH/build && cd $FAUP_PATH/build && cmake .. && make && make install && echo '/usr/local/lib' | tee -a /etc/ld.so.conf.d/faup.conf && ldconfig && cd $FAUP_PATH/src/lib/bindings/python && python setup.py install \
    && git clone https://github.com/VirusTotal/yara.git /opt/yara && cd /opt/yara && ./bootstrap.sh && ./configure && make && make install && pip install yara-python \
    && git clone https://github.com/buffer/pyv8.git /opt/pyv8 && cd /opt/pyv8 && python setup.py build && python setup.py install \
    && git clone https://github.com/buffer/thug.git /opt/thug && cd /opt/thug && python setup.py build && python setup.py install \
    && git clone https://github.com/SpamScope/spamscope.git ${SPAMSCOPE_PATH} && git -C ${SPAMSCOPE_PATH} checkout tags/${SPAMSCOPE_VER} && pip install -r $SPAMSCOPE_PATH/requirements.txt && mkdir -p /var/log/spamscope && mkdir -p /etc/spamscope && cd $SPAMSCOPE_PATH && sparse jar -s \
    && apt-get -yqq purge \
        build-essential \
        cmake \
        curl \
        dh-autoreconf \
        git \
        pkg-config \
        python-pip \
    && apt-get -yqq autoremove && dpkg -l |grep ^rc |awk '{print $2}' |xargs dpkg --purge
COPY my_init.d/topology_submit.sh /opt/
COPY my_init.d/99_template_submit.sh /etc/my_init.d/
