FROM debian:bullseye-slim

COPY tools/generateREADME.sh /tmp/generateREADME.sh

CMD ["/tmp/generateREADME.sh" ]
