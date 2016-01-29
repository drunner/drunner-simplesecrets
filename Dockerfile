# Ansible in a Docker container, accessed via ssh.

FROM j842/dr-baseimage-alpine
MAINTAINER j842

# Sadly this doesn't work with pure volume containers yet. Cmon Docker, sort it!
# Need to work around by first mounting the container for now (done in hostinit).
RUN mkdir /config && chown druser:drgroup /config

ENV DownloadDate 2016-01-23-859
RUN wget --no-cache -nv -O /usr/local/bin/ssdownload https://raw.github.com/j842/scripts/master/ssdownload
RUN chmod a+x /usr/local/bin/ssdownload

# add in the assets.
ADD ["./assets/bin","/usr/local/bin/"]
ADD ["./assets/forhost","/opt/forhost"]
RUN chown druser:drgroup /usr/local/bin/*
RUN chown druser:drgroup /opt/forhost/*

VOLUME ["/config","/dr"]
USER druser