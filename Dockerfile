FROM node:alpine3.16

RUN apk update && \
	apk add --no-cache tini

COPY tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--", "/tmp/entrypoint.sh"]

CMD ["node"]
