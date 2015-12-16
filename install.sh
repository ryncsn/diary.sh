#!/bin/bash

if [ -z "$HOME" ]; then
    exit 1;
fi

DEST="$HOME/.local/bin"

if [ ! -d $DEST ]; then
    echo "Expect to be installed to $DEST."
    echo "But $DEST not found."
fi

cp ./src/life.sh $DEST/life

