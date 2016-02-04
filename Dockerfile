# Ansible in a Docker container, accessed via ssh.

FROM j842/dr-baseimage-alpine
MAINTAINER j842

ENV DownloadDate 2016-01-31-1737
RUN wget --no-cache -nv -O /usr/local/bin/ssdownload https://raw.github.com/j842/scripts/master/ssdownload
RUN chmod a+x /usr/local/bin/ssdownload

# add in the assets.
ADD ["./usrlocalbin","/usr/local/bin/"]
ADD ["./dr","/dr"]
RUN chmod a+rx -R /usr/local/bin  &&  chmod a-w -R /dr

# lock in druser.
USER druser

# expose volume
VOLUME ["/config"]

