FROM ubuntu:18.04

LABEL Maintainer="Daniel van Niekerk <dvn.demitasse@gmail.com>"
LABEL Description="BRAT Rapid Annotation Tool"

ENV BASEDIR=/brat

VOLUME /mnt/work
VOLUME /mnt/data

RUN apt-get clean all && \
    apt-get update && \
    apt-get install --yes --allow-unauthenticated python-ujson git
RUN git clone https://github.com/nlplab/brat.git $BASEDIR

COPY config.py $BASEDIR
COPY run.sh $BASEDIR


## `docker -p 8001:8001 run -v $DATADIR:/mnt/data -v $WORKDIR:/mnt/work brat`
############################################################
WORKDIR $BASEDIR
RUN git checkout 0c9a4f9
RUN ln -s /mnt/work work && \
    ln -s /mnt/data data
CMD bash run.sh
