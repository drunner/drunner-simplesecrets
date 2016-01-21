# Ansible in a Docker container, accessed via ssh.

FROM debian
MAINTAINER j842

RUN apt-get update && \
    apt-get install -y \
    curl

ADD ["./assets/","/usr/local/bin/"]

VOLUME ["/config"]
CMD ["/usr/local/bin/simplesecrets"]
