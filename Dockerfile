FROM alpine:edge
LABEL maintainer="Teddysun <i@teddysun.com>"

RUN apk add --no-cache ca-certificates bash openssl libreswan xl2tpd \
	&& ipsec initnss \
	&& rm -rf /var/cache/apk/*

COPY ipsec /etc/init.d/ipsec
COPY l2tp.sh /usr/bin/l2tp
COPY l2tpctl.sh /usr/bin/l2tpctl
COPY chap-secrets /root/chap-secrets
RUN chmod 755 /etc/init.d/ipsec /usr/bin/l2tp /usr/bin/l2tpctl

VOLUME /lib/modules

EXPOSE 500/udp 4500/udp

CMD [ "l2tp" ]