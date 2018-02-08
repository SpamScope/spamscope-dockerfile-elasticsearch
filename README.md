[![Build Status](https://travis-ci.org/SpamScope/spamscope-dockerfile-elasticsearch.svg?branch=master)](https://travis-ci.org/SpamScope/spamscope-dockerfile-elasticsearch)
[![](https://images.microbadger.com/badges/image/fmantuano/spamscope-elasticsearch.svg)](https://microbadger.com/images/fmantuano/spamscope-elasticsearch "Get your own image badge on microbadger.com")

![SpamScope](https://github.com/SpamScope/spamscope/blob/develop/docs/logo/spamscope.jpg?raw=true "SpamScope")

**spamscope-dockerfile-elasticsearch** is a dockerfile to build [fmantuano/spamscope-elasticsearch](https://hub.docker.com/r/fmantuano/spamscope-elasticsearch/) Docker image.
This image must be used with an elasticsearch container, where you'll save your analysis.

**fmantuano/spamscope-elasticsearch** is an all-in-one  image that allows you to run a container with:
  - [Apache Storm](http://storm.apache.org/)
  - [SpamScope](https://github.com/SpamScope/spamscope)
  - [Thug](https://github.com/buffer/thug)

SpamScope is an Advanced Spam Analyzer. For more details visit [GitHub project](https://github.com/SpamScope/spamscope).


## Usage

To use spamscope-elasticsearch, you should start an elasticsearch container, then you should connect it with the spamscope container.

To create a new instance, with the right volumes of the configurations, use the following snippet:

```
$ sudo docker run --name spamscope -p 8080:8080 -d -v /local/mails:/mnt/mails -v /local/conf:/etc/spamscope/ fmantuano/spamscope-elasticsearch
```

Then you must submit elasticsearch topology:

```
$ sudo docker exec -d spamscope spamscope-topology submit -g spamscope_elasticsearch
```

Please check `spamscope-topology submit -h` for more details.


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

For more details go to [SpamScope project](https://github.com/SpamScope/spamscope).
