#!/bin/bash

if [ -e $0 ]; then
    echo cat "$0"
    cat "$0"
else
    echo cat /etc/hosts
    cat /etc/hosts
fi
