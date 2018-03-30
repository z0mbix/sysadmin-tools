#!/bin/sh
#
# Desctiption:
#   Create a new SVN repo with or without the branches/tags/trunk structure
# Requirements:
#   Subversion
#

NEWREPO=$1
REPODIR=/var/svn/repositories
USER=csvn
GROUP=csvn

if [ $# != 1 ]; then
	echo "Usage $0 newreponame"
	exit 1
fi

svnadmin create $REPODIR/$NEWREPO

echo -n "Do you want to create the branches/tags/trunk structure for this repo? (y/n) "
read ANSWER
if [ "$ANSWER" == "y" ]; then
	svn mkdir file://$REPODIR/$NEWREPO/trunk file://$REPODIR/$NEWREPO/tags file://$REPODIR/$NEWREPO/branches -m "Creating initial branch structure" --no-auth-cache --non-interactive --quiet
fi

chown -R $USER:$GROUP $REPODIR/$NEWREPO
