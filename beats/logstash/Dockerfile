from logstash:5

WORKDIR  /opt/logstash
RUN   ./bin/logstash-plugin install logstash-input-beats

COPY logstash.conf /config-dir/

CMD ["-f", "/config-dir/logstash.conf"]

