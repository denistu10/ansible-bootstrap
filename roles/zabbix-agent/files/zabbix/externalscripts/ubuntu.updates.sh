#!/bin/bash

# apt-get update && apt-get install update-notifier-common

UPDATES_COUNT=$(/usr/lib/update-notifier/apt-check 2>&1||echo "-1;-1")
CACHEFILE=/tmp/ubuntu.updates.cache

echo ${UPDATES_COUNT} > ${CACHEFILE}

case $1 in

updates)
        cat ${CACHEFILE} | cut -d';' -f1
;;

securityupdates)
        cat ${CACHEFILE} | cut -d';' -f2
;;

listupgrades)
        nice apt-get -s -o Debug::NoLocking=true upgrade | grep ^Inst | sed 's/Inst //' 2>&1||echo "0"
;;

release)
        lsb_release -a 2>/dev/null | grep Release | awk '{print $2}'
;;

esac
