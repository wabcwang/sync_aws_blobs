#!/bin/bash
# create by wabcwang@126.com

if [ $# -lt 1  ]; then
        echo "$0  BASE_PATH VERSION"
        echo "$0  /home/XXX/XXX/cf-release 225"
        exit 0
fi

./down_blob.sh $1 $1/releases/cf-${2}.yml
