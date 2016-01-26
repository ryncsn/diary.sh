#!/bin/bash

if [ -z "$HOME" ]; then
    exit 1;
fi

DIR="$HOME/life"
LOG="$DIR/log"
EDITOR='vim'

if [ ! -d $DIR ]; then
    mkdir -p $DIR
fi

case $1 in
    "today" )
        DAY=$(date +"%Y-%m-%d")
        $EDITOR $LOG/${DAY}.log
        ;;
    "yesterday" )
        DAY=$(date --date="yesterday" +"%Y-%m-%d")
        $EDITOR $LOG/${DAY}.log
        ;;
    "log" )
        for i in $(ls $LOG | sort -r);
        do
            echo "----------${i##*/}----------";
            cat $LOG/$i;
            echo -e "\n\n\n";
        done | less
        ;;
    * )
        echo "a small tool give you manage diary in terminal"
        ;;
esac

