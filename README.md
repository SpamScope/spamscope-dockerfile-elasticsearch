![SpamScope](https://github.com/SpamScope/spamscope/blob/develop/docs/logo/spamscope.jpg?raw=true "SpamScope")

**spamscope-dockerfile-elasticsearch** is a dockerfile to build [fmantuano/spamscope-elasticsearch](https://hub.docker.com/r/fmantuano/spamscope-elasticsearch/) Docker image.
This image must be used with an elasticsearch container, where you'll save your analysis.

**fmantuano/spamscope-elasticsearch** is an all-in-one [Apache Storm](http://storm.apache.org/) image that allows you to run a container with:
  - Zookeeper
  - Nimbus
  - Supervisor
  - Storm UI on port 8080

run [SpamScope](https://github.com/SpamScope/spamscope) and submit the debug topology.

SpamScope is an Advanced Spam Analyzer. For more details visit [GitHub project](https://github.com/SpamScope/spamscope).


## Usage

To use spamscope-elasticsearch, you should start an elasticsearch container with `elastisearch` name, then you should connect it with the spamscope container.

To create a new instance, with the right volumes of the configurations, use the following snippet:

```
$ sudo docker run --name spamscope -p 8080:8080 -d -v /local/mails:/mnt/mails -v /local/conf:/etc/spamscope/ fmantuano/spamscope-elasticsearch
```

Then you must submit elasticsearch topology:

```
$ sudo docker exec -d spamscope /opt/topology_submit.sh
```

If you want to change submit parameters, you should change the script in `my_init.d/topology_submit` and rebuild the image:

```
$ sudo docker build --force-rm -t your_user/spamscope-elasticsearch .
```

Once the docker instance is created, you can control it by running:

```
$ sudo docker start spamscope

$ sudo docker stop spamscope
```

To exec an interactive shell:

```
$ sudo docker exec -ti spamscope /bin/bash
```

## Apache Storm settings

It's possible change the default setting for all Apache Storm options. I suggest for SpamScope these options:

 - **topology.tick.tuple.freq.secs**: reload configuration of all bolts
 - **topology.max.spout.pending**: Apache Storm framework will then throttle your spout as needed to meet the `topology.max.spout.pending` requirement
 - **topology.sleep.spout.wait.strategy.time.ms**: max sleep for emit new tuple (mail)

For SpamScope I tested these values to avoid failed tuples:

```
topology.tick.tuple.freq.secs: 60
topology.max.spout.pending: 200
topology.sleep.spout.wait.strategy.time.ms: 10
```

If Apache Tika is enabled:

```
topology.max.spout.pending: 100
```
