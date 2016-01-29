# Ansible in a Docker container, accessed via ssh.

FROM alpine
MAINTAINER j842

# we use non-root user in the container for security.
# dr expects uid 22022 and gid 22022.
RUN apk add --update bash curl wget && rm -rf /var/cache/apk/*
RUN addgroup -S -g 22022 drgroup
RUN adduser -S -u 22022 -G drgroup -g '' druser

# create the mount point and allow druser to write to it.
RUN mkdir /dr && chown druser:drgroup /dr

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