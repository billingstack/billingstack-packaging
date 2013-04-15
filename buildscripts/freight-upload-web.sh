#!/bin/bash

set -x

# Script to copy the newly-built debs to the web node for signing and promoting

# Dependencies
# * the freight::client class in foreman-infra
# * the web node (server2) must have the freight class applied

DISTRO="$1"
COMPONENT="$2"
DEB_PATH="$3"

SSH_KEY=~/ssh_key_freight
USER=freight
HOST=cloudistic.me


TARGET_PATH=rsync_cache/$DISTRO/$COMPONENT/
echo "$COMPONENT $DISTRO $DEB_PATH $TARGET_PATH"

# Export this to avoid quoting issues
SSH_CON="$USER@$HOST"
SSH="ssh -i $SSH_KEY"

# Set the RSYNC_RSH for rsync
export RSYNC_RSH=$SSH

# Create the directory
#$SSH $SSH_CON "mkdir -p $TARGET_PATH"


/usr/bin/rsync -avPx $DEB_PATH/*deb $SSH_CON:$TARGET_PATH
