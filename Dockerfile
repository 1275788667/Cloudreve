FROM golang:alpine

WORKDIR /cloudreve

COPY * .

RUN ls

RUN apk update \
    && apk add --no-cache tzdata git \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone 

RUN go build -o cloudreve \
    && chmod +x ./cloudreve \
    && mkdir -p /data/aria2 \
    && chmod -R 766 /data/aria2

EXPOSE 5212
VOLUME ["/cloudreve/uploads", "/cloudreve/avatar", "/data"]

ENTRYPOINT ["./cloudreve"]

