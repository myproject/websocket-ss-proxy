FROM alpine:latest

ENV METHOD aes-256-cfb

# RUN mkdir -m 777 /ss
RUN mkdir -m 777 /webdir

RUN set -ex \
    && apk --update add --no-cache python libsodium rng-tools curl \
    && apk del curl \
    && rm -rf /var/cache/apk

RUN pip install honcho
RUN pip install numpy
RUN pip install shadowsocks
RUN pip install websockify

ADD entrypoint.sh /entrypoint.sh
ADD webdir/index.html /webdir/index.html
ADD Procfile.honcho /Procfile.honcho

RUN chmod +x /Procfile.honcho
RUN chmod +x /webdir/index.html

# ENTRYPOINT  /entrypoint.sh 

# EXPOSE 8686

CMD honcho start -f Procfile.honcho