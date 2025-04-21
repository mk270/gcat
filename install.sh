#!/bin/bash

set -eu

PKG=$(basename $(realpath $(dirname $0)))

STOW=/usr/local/stow
DIR=$STOW/$PKG

if [ -d $DIR ]; then
    find $DIR -mindepth 1 -maxdepth 1 -exec rm -rf - {} \;
fi

BASE=$(dirname $0)

if [ -d $BASE/bin ]; then
    install -d $DIR/bin
    install -m 755 -t $DIR/bin bin/*
fi

if [ -d $BASE/man ]; then
    # note we're assuming there's only section 1
    MANDIR=share/man/man1
    install -d $DIR/$MANDIR
    install -m 644 -t $DIR/$MANDIR man/*
fi

if [ -d $BASE/share ]; then
    # note we're assuming it's all non-executable
    install -d $DIR/share
    install -m 644 -t $DIR/share share/*
fi

cd $STOW
stow $PKG
