FROM golang:alpine

RUN \
    sed -i 's/\/\/[^\/]*/\/\/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk --no-cache update \
    && apk --no-cache upgrade \
    && apk --no-cache add bash sshpass curl git \
    && git clone https://github.com/golang/tools.git src/golang.org/x/tools \
    && git clone https://github.com/golang/lint.git src/golang.org/x/lint \
    && go get -v -u github.com/mdempsky/gocode \
    && go get -v -u github.com/uudashr/gopkgs/cmd/gopkgs \
    && go get -v -u github.com/ramya-rao-a/go-outline \
    && go get -v -u github.com/acroca/go-symbols \
    && go get -v -u github.com/cweill/gotests/gotests \
    && go get -v -u github.com/fatih/gomodifytags \
    && go get -v -u github.com/josharian/impl \
    && go get -v -u github.com/davidrjenni/reftools/cmd/fillstruct \
    && go get -v -u github.com/haya14busa/goplay/cmd/goplay \
    && go get -v -u github.com/godoctor/godoctor \
    && go get -v -u github.com/go-delve/delve/cmd/dlv \
    && git clone https://github.com/stamblerre/gocode.git src/github.com/stamblerre/gocode \
    && go build -o bin/gocode-gomod github.com/stamblerre/gocode \
    && go get -v -u github.com/rogpeppe/godef \
    && go get -v -u github.com/sqs/goreturns \
    && go get -v -u golang.org/x/tools/cmd/guru \
    && go get -v -u golang.org/x/tools/cmd/gorename \
    && go get -v -u golang.org/x/lint/golint
