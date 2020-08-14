FROM alpine
# https://iperf.fr/iperf-doc.php
RUN \
    sed -i 's/\/\/[^\/]*/\/\/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk --no-cache update \
    && apk --no-cache upgrade \
    && apk --no-cache add curl iperf
EXPOSE 5001
EXPOSE 5002
