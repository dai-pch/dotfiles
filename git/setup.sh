#!/usr/bin/env bash

GIT_CMD="$(which git)"

if [ ! -z "$GIT_CMD" ]; then
    if [ -z "$(git config --get user.email)" ]; then
        git config --global user.email="dpc_work@163.com"
    fi
    if [ -z "$(git config --get user.name)" ]; then
        git config --global user.name="Dai, Pengcheng"
    fi
fi

