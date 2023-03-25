FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    git

COPY tools/generateREADME.sh /tmp/generateREADME.sh

WORKDIR /main

CMD ["/tmp/generateREADME.sh" ]
