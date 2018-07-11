FROM coldljy/centos-java

ARG FLUME_VERSION="1.8.0"
ARG APACHE_MIRROR="https://dist.apache.org/repos/dist/release"
ARG APACHE_DIST_MIRROR="https://dist.apache.org/repos/dist/release"

RUN set -x \
	&& cd /tmp \

	# Install flume
	&& curl -fSL "${APACHE_MIRROR}/flume/${FLUME_VERSION}/apache-flume-${FLUME_VERSION}-bin.tar.gz" -o apache-flume-${FLUME_VERSION}-bin.tar.gz \
	&& mkdir -p /flume \
	&& tar xvzf apache-flume-${FLUME_VERSION}-bin.tar.gz -C /flume --strip-components 1 \
	&& rm -rf /tmp/apache-flume-* \

	# Copy default properties
	&& cp /flume/conf/flume-conf.properties.template /flume/conf/flume.properties

	# Install envsubst for dynamic config file


EXPOSE 41414
WORKDIR /flume
# Expose flume config dir as a volume
VOLUME /flume/conf

# Entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
