#!/bin/bash
# =============================================================================
# Container entrypoint
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

mkdir -p /var/cache/bind

chown -R named:named /etc/bind /var/lib/bind
chown -R root:named /var/cache/bind

chmod -R u+rw,g+rw,o-rwx /var/cache/bind /var/lib/bind
chmod -R u+rw,g+w,g-w,o-rwx /etc/bind 

/usr/sbin/named -u named -c /etc/bind/named.conf -g
