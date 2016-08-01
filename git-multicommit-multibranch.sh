#!/bin/bash
BRANCHES=(
dev
devprod
prod
production
qatest
sb
uat
)
COMMITS=(
7b0141f
355639a
8dc82bd
)
#
ORIGINALBRANCHDEFAULT=testbranch
ORIGINALBRANCH=$ORIGINALBRANCHDEFAULT
#
git checkout $ORIGINALBRANCH;
echo "This is the original branch $ORIGINALBRANCH"
for COMMIT in "${COMMITS[@]}";
do
	#CHERRYCOMMIT=`git log -n1 | head -n1 | awk '{print $2}'`
	CHERRYCOMMIT=$COMMIT
	echo "This is the original cherry-pick $CHERRYCOMMIT"
	for BRANCH in "${BRANCHES[@]}";
	do
		echo "Current branch is $BRANCH";
		git stash;
		git checkout $BRANCH;
		git cherry-pick $CHERRYCOMMIT;
		git checkout $ORIGINALBRANCH;
		git stash pop;
	done
done
