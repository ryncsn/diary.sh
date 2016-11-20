#!/bin/bash

if [ -z "$HOME" ]; then
    exit 1;
fi

DEST="$HOME/.local/bin"

if [ ! -d $DEST ]; then
    echo "Expected to be installed to $DEST."
    echo "But $DEST not found."
fi

cp ./src/diary.sh $DEST/diary.sh
