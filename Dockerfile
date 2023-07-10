# =============================================================================
# Dockerfile
# Bind Name Server Container
# https://github.com/aessing/bind-container
# -----------------------------------------------------------------------------
# Developer.......: Andre Essing (https://github.com/aessing)
#                                (https://www.linkedin.com/in/aessing/)
# -----------------------------------------------------------------------------
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
# EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
# =============================================================================

###############################################################################
# Get the base Linux image
FROM alpine:3.18

###############################################################################
# Set parameters
ARG BUILD_DATE
ENV TZ='UTC'
EXPOSE 53/tcp \
       53/udp \
       80/tcp \
       443/tcp \ 
       853/tcp
VOLUME ["/etc/bind", "/var/lib/bind"]

###############################################################################
# Set some information
LABEL org.opencontainers.image.created=${BUILD_DATE} \
      org.opencontainers.image.authors="Andre Essing" \
      org.opencontainers.image.description="BIND is an open source DNS software system including an authoritative server or a recursive resolver." \
      org.opencontainers.image.documentation="https://github.com/aessing/bind-container" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="Bind Name Server Container" \
      org.opencontainers.image.url="https://github.com/aessing/bind-container" \
      org.opencontainers.image.vendor="Andre Essing"

################################################### ############################
# Install chronyd and necessary packages
RUN apk add --update --no-cache bind ca-certificates tzdata \
    && update-ca-certificates \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo $TZ > /etc/timezone \
    && mkdir -p /etc/bind /var/lib/bind /var/cache/bind \
    && chown -R named:named /etc/bind /var/lib/bind \
    && chown -R root:named /var/cache/bind \
    && chmod -R u+rw,g+rw,o-rwx /var/cache/bind /var/lib/bind \
    && chmod -R u+rw,g+w,g-w,o-rwx /etc/bind 

###############################################################################
# Copy files
COPY container-files/named.conf /etc/bind/named.conf
COPY container-files/db.* /var/lib/bind/zones/

###############################################################################
# Healthcheck
HEALTHCHECK CMD dig +norecurse +short +retry=0 @127.0.0.1 localhost || exit 1

###############################################################################
# Start chronyd
CMD [ "/usr/sbin/named", "-g", "-u", "named", "-c", "/etc/bind/named.conf" ]

###############################################################################
#EOF