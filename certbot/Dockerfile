
#jmorille/certbot
FROM debian


# Expose
# #######################
EXPOSE 80 443
VOLUME ["/data/certs", "/etc/letsencrypt", "/var/lib/letsencrypt" ]


ENV DEBIAN_FRONTEND="noninteractive"
WORKDIR /opt/certbot

# Config proxy env
# #######################
# ENV http_proxy="http://proxy:3128"  no_proxy=""
# HTTP_PROXY="$http_proxy" https_proxy="$http_proxy" HTTPS_PROXY="$http_proxy" NO_PROXY="$no_proxy"


# Install tools
# #######################
RUN apt-get update && apt-get install -y wget

# Install certbot
# #######################
RUN wget https://dl.eff.org/certbot-auto && \
    chmod a+x certbot-auto
# Check the download integrity
#RUN wget -N https://dl.eff.org/certbot-auto.asc  && \
#    gpg --recv-key A2CFB51FA275A7286234E7B24D17C995CD9775F2  && \
#    gpg --trusted-key 4D17C995CD9775F2 --verify certbot-auto.asc certbot-auto

RUN  /opt/certbot/certbot-auto --help && \
     /opt/certbot/certbot-auto -n  --os-packages-only -i standalone

#RUN    ./certbot-auto -n  -d thor
