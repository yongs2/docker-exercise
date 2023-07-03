# Refer https://github.com/justb4/docker-jmeter
FROM alpine:3.18

LABEL maintainer="yongs2@hotmail.com"

# Arguments
ARG JDK_VERSION=11
ARG JMETER_VERSION=5.5
ARG HTTP2_VERSION=2.0.2

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_CUSTOM_DEPENDENCIES /dependencies
ENV JMETER_CUSTOM_PLUGINS_FOLDER /plugins
ENV JMETER_CUSTOM_PROPERTIES /properties
ENV	JMETER_BIN	${JMETER_HOME}/bin
ENV	JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV PLUGIN_HTTP2_URL  https://jmeter-plugins.org/files/packages/bzm-http2-${HTTP2_VERSION}.zip

# Install extra packages
# Set TimeZone, See: https://github.com/gliderlabs/docker-alpine/issues/136#issuecomment-612751142
ARG TZ="Asia/Seoul"
ENV TZ ${TZ}
RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update openjdk${JDK_VERSION}-jre tzdata curl unzip bash \
	&& apk add --no-cache nss \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf /tmp/dependencies

# Install jmeter-plugins
RUN    mkdir -p /tmp/dependencies  \
    && curl -L --silent ${PLUGIN_HTTP2_URL} >  /tmp/dependencies/bzm-http2-${HTTP2_VERSION}.zip \
    && unzip /tmp/dependencies/bzm-http2-${HTTP2_VERSION}.zip -d ${JMETER_HOME} \
    && rm -rf /tmp/dependencies

# Set global PATH such that "jmeter" command is found
ENV PATH $PATH:$JMETER_BIN

# Entrypoint has same signature as "jmeter" command
COPY entrypoint.sh /

EXPOSE 1099

WORKDIR	${JMETER_HOME}

ENTRYPOINT ["/entrypoint.sh"]
