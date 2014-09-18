FROM ubuntu:14.04
MAINTAINER Vachagan Gevorgyan <va4@astralteam.com>

# Download latest package lists
RUN apt-get update

# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq \
    openjdk-7-jre-headless \
    wget \ 
    git-core



# # Download version 1.4.2 of logstash
RUN cd /tmp && \
     wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && \
     tar -xzvf ./logstash-1.4.2.tar.gz && \
     mv ./logstash-1.4.2 /opt/logstash && \
     rm ./logstash-1.4.2.tar.gz

# Install contrib plugins
RUN /opt/logstash/bin/plugin install contrib



# Copy build files to container root
RUN mkdir /runway
ADD ./scripts/ /runway

EXPOSE 9200

# Start boot
ENTRYPOINT ["/runway/boot.sh"]