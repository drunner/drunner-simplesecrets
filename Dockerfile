# simplesecrets

FROM drunner/baseimage-alpine
MAINTAINER j842

# add in the assets.
USER root
ADD ["./usrlocalbin","/usr/local/bin/"]
RUN chmod a+rx -R /usr/local/bin
USER druser

ADD ["./drunner","/drunner"]
