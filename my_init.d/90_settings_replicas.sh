#!/bin/sh

sleep 15

curl --silent -XPUT http://elasticsearch:9200/_settings -d '
{
    "index" : {
        "number_of_replicas" : 0
    }
}'
