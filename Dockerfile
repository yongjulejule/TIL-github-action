FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    git

COPY tools/generateREADME.sh /tmp/generateREADME.sh

COPY test/TIL/ /test/

WORKDIR /test

CMD ["/tmp/generateREADME.sh" ]
