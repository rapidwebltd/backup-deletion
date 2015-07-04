#!/bin/bash
ask() {
    # http://djm.me/ask
    while true; do
 
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi
 
        # Ask the question - use /dev/tty in case stdin is redirected from somewhere else
        read -p "$1 [$prompt] " REPLY </dev/tty
 
        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi
 
        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
 
    done
}

if [ ! -d ".git" ]; then
    echo "There is no .git directory. Since this script is destructive, it should only be used where there is decent version control."
    exit
fi

echo "--------------";

find . -iname '*_[0-9]*[0-9][0-9].php' -o -iname '*_[0-9]*[0-9][0-9].css' -o -iname '*_[0-9]*[0-9][0-9].htm?' | sort

echo "--------------";

if [ ! `find . -iname '*_[0-9]*[0-9][0-9].php' -o -iname '*_[0-9]*[0-9][0-9].css' -o -iname '*_[0-9]*[0-9][0-9].htm?'` ]; then

    echo "No files were identified as backups based on their file names."
    exit
    
fi

echo "The files above have been identified as backups based on their file names. ";

if ask "Flag them for removal from your git repo (git rm)?" Y; then

    git rm `find . -iname '*_[0-9]*[0-9][0-9].php' -o -iname '*_[0-9]*[0-9][0-9].css' -o -iname '*_[0-9]*[0-9][0-9].htm?' | sort`

    if ask "Commit these deletions?" Y; then
    
        git commit -m "Removed files identified as backups."
    
        if ask "Push this commit?" Y; then
        
            if ask "Pull first?" Y; then
        
                git pull
        
            fi
            
            git push
        
        fi 
    
    fi
    
    echo 'Done!'

else

    echo "Nothing to do."

fi

