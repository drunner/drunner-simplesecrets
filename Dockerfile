# Ansible in a Docker container, accessed via ssh.

FROM debian
MAINTAINER j842

RUN apt-get update && \
    apt-get install -y \
    curl wget

ENV DownloadDate 2016-01-23-742
RUN wget --no-cache -nv -O /usr/local/bin/ssdownload https://raw.github.com/j842/scripts/master/ssdownload
RUN chmod a+x /usr/local/bin/ssdownload

ADD ["./assets/","/usr/local/bin/"]

VOLUME ["/config"]
CMD ["/usr/local/bin/simplesecrets"]
