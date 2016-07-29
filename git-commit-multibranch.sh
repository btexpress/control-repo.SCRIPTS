#!/bin/bash
BRANCHES=(
sb-test
uat-test
)
ORIGINALBRANCHDEFAULT=testbranch
#ORIGINALBRANCH=`git status | head -n1 | awk '{print $3}'`
ORIGINALBRANCH=$ORIGINALBRANCHDEFAULT
git checkout $ORIGINALBRANCH;
echo "This is the original branch $ORIGINALBRANCH"
CHERRYCOMMIT=`git log -n1 | head -n1 | awk '{print $2}'`
echo "This is the original cherry-pick $CHERRYCOMMIT"
for BRANCH in "${BRANCHES[@]}";
do
	echo $BRANCH;
	git stash;
	git checkout $BRANCH;
	git cherry-pick $CHERRYCOMMIT;
	git checkout $ORIGINALBRANCH;
	git stash pop;
done
