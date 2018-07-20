FROM lsiobase/alpine.nginx:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="alex-phillips"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache \
	grep \
	php7 \
	php7-gd \
	php7-openssl \
	php7-sqlite3 \
	php7-session && \
 apk add --no-cache --virtual=build-dependencies \
	git && \
 echo "**** install TwoFactorAuth ****" && \
 git clone https://github.com/alex-phillips/TwoFactorAuth.git /app/TwoFactorAuth && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8000
VOLUME /config
