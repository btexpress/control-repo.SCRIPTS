#!/usr/bin/env bash
BRANCHES=(
devprod
prod
production
qatest
sbnote
uat
)
COMMITS=(
75ff6a7
db80955
b631aa2
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
