#!/usr/bin/env bash
BRANCHES=(
dev
devnote
devprod
docker
integration
prod
production
qatest
sb
sbnote
uat
uatnote
)
COMMITS=(
82966dc
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
