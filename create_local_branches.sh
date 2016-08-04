#!/usr/bin/env bash
#
#git branch -r | egrep -v "HEAD|revert"
#
for rbranch in `git branch -r | egrep -v "HEAD|revert|docker"`
do
#	echo $rbranch
	lbranch=`echo $rbranch | awk -F/ '{print $2}'`
#	echo $lbranch
	git checkout -b $lbranch $rbranch
done
