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
    * )
        echo "$0"
        ;;
esac

