FROM python:alpine

WORKDIR /test

COPY pip.conf /tmp
COPY requirements.txt /tmp

RUN \
    sed -i 's/\/\/[^\/]*/\/\/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk --no-cache update \
    && apk --no-cache upgrade \
    && apk --no-cache add gcc libffi-dev openssh openssl-dev make sqlite sqlite-dev mysql-dev unixodbc-dev build-base bash sshpass curl git \
    && mkdir -p /root/.ssh /root/.pip \
    && echo "StrictHostKeyChecking accept-new" > /root/.ssh/config \
    && mv /tmp/pip.conf /root/.pip \
    && pip install -r /tmp/requirements.txt \
    && rm -rf ~/.cache/pip

EXPOSE 8088

CMD ["sh", "-c", "while true; do :; done"]
