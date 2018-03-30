#!/bin/sh
#
# Description:
#   Dump out all subversion repositorys to a compressed file
# Requirements:
#   Subversion
#   pigz or gzip
# Example Usage:
#   cd /data/backups/svn/ && backup_svn_repos.sh
#

REPODIR=/var/lib/svn
TODAY=`date +%Y-%m-%d`
COMP_TOOL=gzip
which pigz >/dev/null && COMP_TOOL=pigz

logger "Dumping All SVN repos to `pwd`/${TODAY}"

mkdir ${TODAY}
cd ${TODAY}

for REPO in `ls $REPODIR`; do
	echo "Dumping repo: $REPO"
	svnadmin dump --quiet $REPODIR/$REPO | $COMP_TOOL > ${REPO}.svn.gz
done

