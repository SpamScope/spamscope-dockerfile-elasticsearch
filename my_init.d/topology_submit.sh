#!/bin/sh

# topology name
TOPOLOGY=spamscope_elasticsearch

# workers number
NR_WORKERS=1

# Seconds reload configuration
TICK=60

# max tuple pending
MAX_PENDING=200

# Milliseconds sleep
SPOUT_SLEEP=10

# Timeout topology in seconds
TIMEOUT=600

cd ${SPAMSCOPE_PATH}

STREAMPARSE_CMD="sparse submit -f -n ${TOPOLOGY} -w ${NR_WORKERS} -o topology.tick.tuple.freq.secs=${TICK} -o topology.max.spout.pending=${MAX_PENDING} -o topology.sleep.spout.wait.strategy.time.ms=${SPOUT_SLEEP} -o supervisor.worker.timeout.secs=${TIMEOUT} -o topology.message.timeout.secs=${TIMEOUT}"

${STREAMPARSE_CMD}
