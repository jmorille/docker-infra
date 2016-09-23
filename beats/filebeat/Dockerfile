from debian

ENV BEATS_VERSION=5.0.0-beta1
ENV FILEBEAT_REPO_BASE=http://packages.elastic.co/beats/apt

# add our user and group first to make sure their IDs get assigned consistently
RUN groupadd --gid 1000 -r beat && useradd -r -m -g beat --uid 1000 beat


RUN apt-get update && apt-get install -y \
		ca-certificates \
		wget \
		curl \
	--no-install-recommends

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true


RUN curl https://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - \
    && echo "deb $FILEBEAT_REPO_BASE stable main" > /etc/apt/sources.list.d/filebeat.list \
    && apt-get update
    RUN apt-get install -y --no-install-recommends filebeat=$BEATS_VERSION \
    && rm -rf /var/lib/apt/lists/*

ADD filebeat.yml /config/filebeat

CMD ["/opt/filebeat", "-e", "-c", "/config/filebeat.yml", "-d", "'"publish'"]
