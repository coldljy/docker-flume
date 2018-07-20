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

	# Remove unused libs or replace by newer
	&& rm -f ${LIB_DIR}/guava-11.0.2.jar \
	&& curl -fSL "http://central.maven.org/maven2/com/google/guava/guava/25.1-jre/guava-25.1-jre.jar" -o  ${LIB_DIR}/guava-25.1-jre.jar \
	&& rm -f ${LIB_DIR}/netty-3.9.4.Final.jar \
	&& curl -fSL "http://central.maven.org/maven2/io/netty/netty-all/4.1.26.Final/netty-all-4.1.26.Final.jar" -o  ${LIB_DIR}/netty-all-4.1.26.Final.jar \
	&& curl -fSL "http://central.maven.org/maven2/com/alibaba/fastjson/1.2.47/fastjson-1.2.47.jar" -o  ${LIB_DIR}/fastjson-1.2.47.jar \

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
