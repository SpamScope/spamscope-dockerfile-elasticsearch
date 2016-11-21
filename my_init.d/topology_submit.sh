#!/bin/sh

# SpamScope configuration
SPAMSCOPE_CONF="/etc/spamscope/spamscope.yml"

# topology name
TOPOLOGY=spamscope_elasticsearch

# workers number
NR_WORKERS=1

# Seconds reload configuration
TICK=60

# max tuple pending
MAX_PENDING=250

# Milliseconds sleep
SPOUT_SLEEP=10

cd ${SPAMSCOPE_PATH}

STREAMPARSE_CMD="sparse submit -f -n ${TOPOLOGY} -w ${NR_WORKERS} -o topology.tick.tuple.freq.secs=${TICK} -o topology.max.spout.pending=${MAX_PENDING} -o topology.sleep.spout.wait.strategy.time.ms=${SPOUT_SLEEP} -o spamscope_conf=${SPAMSCOPE_CONF}"

${STREAMPARSE_CMD}
