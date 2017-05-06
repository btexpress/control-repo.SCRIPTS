#!/usr/bin/env bash
#
branchcount=0
max_retries=5
printf "\n"
# Get current branches MINUS the docker branch and any others that need to be ignored
for i in `git branch | egrep -v "docker" | sed -e  's/[^a-zA-Z0-9]//g'`
do 
    retries=0
    answer=no
    while [ $retries -lt $max_retries ]
    do
        printf "==============================\n"
        printf "Push branch '$i' to puppet? "
        read
        case "$REPLY" in
        [yY][eE][sS]|[yY]|"")
            answer=yes
            break
            ;;
        [nN][oO]|[nN])
            sleep .5
            ((branchcount++))
            printf "Branch count is $branchcount...\n"
            printf "Skipping '$i' branch\n"
            printf "==============================\n"
            continue 2
            ;;  # Skip this branch and continue with next branch
        [qQ])
            break 2
            ;;  # Or exit, or return if the code is in a function
        *)  
            printf "\nInvalid Option ('$REPLY' given)\n" >&2
            if [ $((++retries)) -ge $max_retries ]
            then
                printf "\n<<<<<->>>>>\n"
                printf "Too many retries!\nExiting.\n"
                printf "<<<<<->>>>>\n\n"
                break 2
            fi
            ;;
        esac
    done
    if [ "$answer" = "no" ]; then break; fi   # EOF in read loop
    sleep .5
    ((branchcount++))
    printf "Process commands....\n\n"   # Do something with the entered information
    printf "Branch count is $branchcount...\n"   # Do something with the entered information
    printf "Executing 'git push puppet $i:$i'\n"   # Do something with the entered information
    git push puppet $i:$i   # Push this branch to the live puppet repo
    printf "==============================\n"
done
