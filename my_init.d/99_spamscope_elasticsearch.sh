#!/bin/sh

spamscope-elasticsearch -c elasticsearch template -p ${SPAMSCOPE_PATH}/conf/templates/spamscope.json -n spamscope
spamscope-elasticsearch -c elasticsearch template -p ${SPAMSCOPE_PATH}/conf/templates/commons.json -n commons
spamscope-elasticsearch -c elasticsearch replicas -i ".kibana, spamscope_*" -n 0
