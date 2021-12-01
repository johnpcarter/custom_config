FROM <WEBMETHODS_IS_IMAGE>

LABEL MAINTAINER="John Carter" \
	DESCRIPTION="webMethods Integration Server 10.x" \
	COMMENT="POC's and what not" \
	CUSTOM="false" \
	SAG="true" \
	TYPE="is" \
	BUILD="99" \
	PRIMARY_PORT="5555"
	
ADD --chown=sagadmin configure-custom-wrapper.sh /opt/softwareag

ADD --chown=sagadmin:sagadmin docker-init.sh ./
ADD --chown=sagadmin:sagadmin docker-stop.sh ./
ADD --chown=sagadmin:sagadmin docker-health-check.sh ./

ENTRYPOINT ["./docker-init.sh"]

HEALTHCHECK --interval=30s --timeout=20s --start-period=60s --retries=6 \
	CMD ./docker-health-check.sh

