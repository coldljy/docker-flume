FROM coldljy/centos-java:jre8

LABEL maintainer="coldljy@gmail.com"

ARG FLUME_VERSION="1.8.0"
ARG APACHE_MIRROR="https://dist.apache.org/repos/dist/release"
ARG APACHE_DIST_MIRROR="https://dist.apache.org/repos/dist/release"
ARG DIR="/flume"
ARG LIB_DIR="${DIR}/lib"

RUN set -x \
	&& cd /tmp \

	# Install flume
	&& curl -fSL "${APACHE_MIRROR}/flume/${FLUME_VERSION}/apache-flume-${FLUME_VERSION}-bin.tar.gz" -o apache-flume-${FLUME_VERSION}-bin.tar.gz \
	&& mkdir -p ${DIR} \
	&& tar xvzf apache-flume-${FLUME_VERSION}-bin.tar.gz -C ${DIR} --strip-components 1 \
	&& rm -rf /tmp/apache-flume-* \
	&& rm -rf ${DIR}/docs \

	# Copy default properties
	&& cp ${DIR}/conf/flume-conf.properties.template ${DIR}/conf/flume.properties

	# Install envsubst for dynamic config file

RUN yum -y install gettext

EXPOSE 41414
WORKDIR ${DIR}
# Expose flume config dir as a volume
VOLUME ${DIR}/conf

# Entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
