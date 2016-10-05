from debian:8
# Expose
# #######################
EXPOSE 80 443
VOLUME ["/data/php", "/data/hhvm"]


RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update
RUN apt-get install -y hhvm


CMD "hhvm --hphp -t hhbc -v AllVolatile=true --input-dir /data/php"
