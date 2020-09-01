FROM continuumio/miniconda3:4.7.12

ARG ARTY_URL
ARG ARTY_USER
ARG ARTY_PASSWORD
ARG ARTY_ID
ENV JFROG_CLI_HOME=/opt/jfrog

RUN mkdir /opt/jfrog
WORKDIR /opt/jfrog

RUN apt-get install -y curl
RUN apt-get install -y vim

RUN curl -fL https://getcli.jfrog.io | sh &&  chmod 755 jfrog &&  mv jfrog /usr/local/bin/

RUN jfrog rt c --interactive=false --url=$ARTY_URL --user=$ARTY_USER --password=$ARTY_PASSWORD $ARTY_ID

RUN jfrog rt use $ARTY_ID

# hack
RUN chmod 777 -R /opt/conda/lib/python3.7/site-packages/ /opt/jfrog

CMD ["/bin/bash", "-c", "jfrog rt c show"]