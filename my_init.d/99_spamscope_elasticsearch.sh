#!/bin/sh

spamscope-elasticsearch -c elasticsearch template -p ${SPAMSCOPE_PATH}/conf/templates/spamscope_mails.json -n spamscope_mails
spamscope-elasticsearch -c elasticsearch template -p ${SPAMSCOPE_PATH}/conf/templates/spamscope_attachments.json -n spamscope_attachments
spamscope-elasticsearch -c elasticsearch template -p ${SPAMSCOPE_PATH}/conf/templates/commons.json -n commons
spamscope-elasticsearch -c elasticsearch replicas -i ".kibana, spamscope_*" -n 0
