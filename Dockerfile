FROM alpine:latest

ENV METHOD aes-256-cfb

# RUN mkdir -m 777 /ss
RUN mkdir -m 777 /webdir

RUN set -ex \
    && apk --update add --no-cache python=3.6.2 honcho numpy shadowsocks websockify libsodium rng-tools \
    && rm -rf /var/cache/apk

# CMD pip install honcho
# CMD pip install numpy
# CMD pip install shadowsocks
# CMD pip install websockify

ADD entrypoint.sh /entrypoint.sh
ADD webdir/index.html /webdir/index.html
ADD Procfile.honcho /Procfile.honcho

RUN chmod +x /Procfile.honcho
RUN chmod +x /webdir/index.html

# ENTRYPOINT  /entrypoint.sh 

# EXPOSE 8686

CMD honcho start -f Procfile.honcho