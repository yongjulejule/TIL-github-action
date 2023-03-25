FROM debian:bullseye-slim

COPY tools/entrypoint.sh /tmp/entrypoint.sh
COPY tools/generateREADME.sh /tmp/generateREADME.sh

ENTRYPOINT ["/tmp/entrypoint.sh"]

CMD ["/tmp/generateREADME.sh"]
