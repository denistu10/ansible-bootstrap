#!/bin/bash

NGINXHOST=127.0.0.1
NGINXPORT=80
NGINXSTATUS=server-status
CURL=`which curl`
NGINXCACHEFILE=/tmp/nginx.stat.cache
NGINXCHECK=`ps aux | grep nginx | grep master | awk '{print $11,$12,$13}'`

$CURL -s "http://$NGINXHOST:$NGINXPORT/$NGINXSTATUS" > $NGINXCACHEFILE

case $1 in

active)
        cat $NGINXCACHEFILE | grep "Active connections" | awk '{print $3}'
;;

accepts)
        cat $NGINXCACHEFILE | sed -n '3p' | awk '{print $1}'
;;

handled)
        cat $NGINXCACHEFILE | sed -n '3p' | awk '{print $2}'
;;

requests)
        cat $NGINXCACHEFILE | sed -n '3p' | awk '{print $3}'
;;

reading)
        cat $NGINXCACHEFILE | grep "Reading" | awk '{print $2}'
;;

writing)
        cat $NGINXCACHEFILE | grep "Writing" | awk '{print $4}'
;;

waiting)
        cat $NGINXCACHEFILE | grep "Waiting" | awk '{print $6}'
;;

status)
        if [ "$NGINXCHECK" == 'nginx: master process' ];
                then
                        echo 1
                else
                        echo 0
        fi


esac

