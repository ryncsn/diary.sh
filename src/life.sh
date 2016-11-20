#!/bin/bash

if [ -z "$HOME" ]; then
    exit 1;
fi

DIR="$HOME/diary.sh"
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

    "encrypt" )
        if [ -f $DIR/.encrypt.lock ]; then
            echo "Already Encrypted, You can try 'chpasswd' or 'decrypt'."
        fi

        while true; do
            read -s -p "Password:" pass
            read -s -p "Again:" pass_chk
            if [ $pass == $pass_chk ]; then
                break
            fi
        done

        touch $DIR/.encrypt.lock

        total=$(ls $LOG | count);
        echo $(ls $LOG)
        count=1;

        echo "Encrypting with openssl aes-256-cbc..."
        mkdir -m 700 -p $DIR/.tmp
        for i in $(ls $LOG | sort -r); do
            echo -ne "$pass\n$pass" | openssl aes-256-cbc -salt -in $LOG/$i -out $DIR/.tmp/$i.tmp
            mv $DIR/.tmp/$i.tmp $i
            if [ $? -ne 0 ]; then
                echo "Error Encrypting."
                rm -Rf $DIR/.tmp
                rm $DIR/.encrypt.lock
                exit 1
            fi
            count=$((count+1))
            echo -ne "$count/$total Encrypted...\r"
        done
        rm -Rf $LOG
        mv $DIR/.tmp $LOG
        echo "Done!"
        ;;

    "decrypt" )
        if [ ! -f $DIR/.encrypt.lock ]; then
            echo "Not Encrypted. You can use -f to force decrypt."
        fi
        ;;

    * )
        echo "A small tool help you manage diary in terminal"
        echo "Usage:"
        echo "  diary.sh [today|yestarday|log]"
        echo "  today: Write your diary/log for today."
        echo "  yesterday: Write/view you diary/log for yesterday."
        echo "  log: View all you diary/logs"
        ;;

esac

