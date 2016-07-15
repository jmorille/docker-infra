
#jmorille/certbot
FROM debian

VOLUME ["/data/cert"]

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
RUN    ./certbot-auto -n  -d thor
