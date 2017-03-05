#!/bin/sh

spamscope-elasticsearch template -p ${SPAMSCOPE_PATH}/conf/templates/spamscope.json -n spamscope
spamscope-elasticsearch template -p ${SPAMSCOPE_PATH}/conf/templates/commons.json -n commons
spamscope-elasticsearch replicas
