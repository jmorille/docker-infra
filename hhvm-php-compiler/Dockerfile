from debian:8

ENV HHVM_ADM_PASSWORD="admin"

# Expose
# #######################
EXPOSE 8080  9000 9001
VOLUME ["/data/php", "/data/hhvm", "/var/log/hhvm", "/var/run/hhvm"]

WORKDIR /data/hhvm

# Install
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update
RUN apt-get install -y hhvm

CMD "hh_client check /data/php"
#CMD "hhvm --hphp -t hhbc -v AllVolatile=false --input-dir /data/php --output-dir /data/hhvm"
# CMD "hhvm -m server -p 8080 "
# CMD "hhvm --mode server -d hhvm.server.type=fastcgi -d hhvm.repo.central.path=/data/hhvm -d hhvm.server.file_socket=/var/run/hhvm/sock"
#CMD "hhvm --mode server -d hhvm.server.type=fastcgi -d hhvm.repo.central.path=/data/hhvm/hhvm.hhbc -d hhvm.server.port=9000 -d hhvm.admin_server.port=9001 -d hhvm.admin_server.password=$HHVM_ADM_PASSWORD"
