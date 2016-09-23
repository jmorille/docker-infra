from debian

ENV BEATS_VERSION=1.3.1
ENV FILEBEAT_SHA1=693c04e2251498e73436cfc2b36a3a0aec920a2d

# add our user and group first to make sure their IDs get assigned consistently
RUN groupadd -r beat && useradd -r -m -g beat beat


RUN apt-get update && apt-get install -y \
		ca-certificates \
		wget \
	--no-install-recommends && rm -rf /var/lib/apt/lists/*


# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

# grab tini for signal processing and zombie killing
ENV TINI_VERSION v0.9.0
RUN set -x \
	&& wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini" \
	&& wget -O /usr/local/bin/tini.asc "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5 \
	&& gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini \
	&& rm -r "$GNUPGHOME" /usr/local/bin/tini.asc \
	&& chmod +x /usr/local/bin/tini \
	&& tini -h


RUN set -x \
	&& wget -O filebeat.tar.gz "https://download.elastic.co/beats/filebeat/filebeat-${BEATS_VERSION}-x86_64.tar.gz" \
	&& echo "${FILEBEAT_SHA1} *filebeat.tar.gz" | sha1sum -c - \
	&& mkdir -p /opt/filebeat \
	&& tar -xz --strip-components=1 -C /opt/beats -f filebeat.tar.gz \
	&& chown -R beat:beat /opt/filebeat \
	&& rm filebeat.tar.gz


ADD filebeat.yml /opt/filebeat

CMD ["/opt/filebeat", "e']
