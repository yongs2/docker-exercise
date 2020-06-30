FROM docker.io/ubuntu:focal
# ubuntu 20.04 LTS (Focal Fossa )

LABEL MAINTAINER=yongs2@hotmail.com

USER root

# install ffmpeg
RUN apt-get -y update \
    && apt-get -y install curl \
    && apt-get -y install ffmpeg

# for youtube-dl
RUN apt-get -y install python3 \
    && ln -s /usr/bin/python3 /usr/bin/python

# install youtube-dl
RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl \
    && chmod a+rx /usr/local/bin/youtube-dl

WORKDIR /work

COPY youtube-dl-audio.sh /work/
RUN chmod +x youtube-dl-audio.sh

CMD ["/bin/bash"]
