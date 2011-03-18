#!/bin/sh
#
# Description:
#   Rename the filename of all files listed as arguments to all uppercase
# Requirements:
#   A shell
#

for file in $@; do
	filename=${file##*/}
	case "$filename" in
		*/*) dirname==${file%/*} ;;
		*) dirname=.;;
	esac
	nf=$(echo $filename | tr A-Z a-z)
	newname="${dirname}/${nf}"
	if [ "$nf" != "$filename" ]; then
		echo "$file => $newname"
		mv "$file" "$newname"
	fi
done
