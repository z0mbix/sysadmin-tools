#!/bin/sh
#
# Description:
#   Dump out all subversion repositorys to a compressed file
# Requirements:
#   Subversion
#   pigz or gzip

REPODIR=/var/lib/svn
TODAY=`date +%Y-%m-%d`
COMP_TOOL=gzip
which pigz && COMP_TOOL=pigz

logger "Dumping All SVN repos to ${TODAY}"

mkdir ${TODAY}
cd ${TODAY}

for REPO in `ls $REPODIR`; do
	echo "Dumping repo: $REPO"
	svnadmin dump --quiet $REPODIR/$REPO | $COMP_TOOL > ${REPO}.svn.gz
done

