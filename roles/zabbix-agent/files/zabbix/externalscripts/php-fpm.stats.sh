#!/bin/bash

PHP=`which php`
PHPCACHEFILE=/tmp/php-fpm.stats.cache

SCRIPT_NAME=/status \
SCRIPT_FILENAME=/status \
QUERY_STRING= \
REQUEST_METHOD=GET \
cgi-fcgi -bind -connect 127.0.0.1:9071 > $PHPCACHEFILE

case $1 in

status)
        PHPSTATUS=`${PHP} -r "echo 'ok';" | grep "ok"`
        if [ "$PHPSTATUS" == 'ok' ];
        then
                echo 1
        else
                echo 0
        fi
;;

uptime)
        cat $PHPCACHEFILE | grep "start since" | cut -d ":" -f 2 | sed 's/^[ \t]*//'
;;

accepted)
        cat $PHPCACHEFILE | grep "accepted conn" | cut -d ":" -f 2 | sed 's/^[ \t]*//'
;;

listenqueue)
        cat $PHPCACHEFILE | grep ^"listen queue" | cut -d ":" -f 2 | sed 's/^[ \t]*//' | sed '2d'
;;

maxlistenqueue)
        cat $PHPCACHEFILE | grep "max listen queue" | cut -d ":" -f 2 | sed 's/^[ \t]*//'
;;

idleproc)
        cat $PHPCACHEFILE | grep "idle processes" | cut -d ":" -f 2 | sed 's/^[ \t]*//'
;;

activeproc)
        cat $PHPCACHEFILE | grep ^"active processes" | cut -d ":" -f 2 | sed 's/^[ \t]*//'
;;

totalproc)
        cat $PHPCACHEFILE | grep "total processes" | cut -d ":" -f 2 | sed 's/^[ \t]*//'
;;

maxactiveproc)
        cat $PHPCACHEFILE | grep "max active processes" | cut -d ":" -f 2 | sed 's/^[ \t]*//'
;;

maxchildren)
        cat $PHPCACHEFILE | grep "max children reached" | cut -d ":" -f 2 | sed 's/^[ \t]*//'
;;

version)
        $PHP -v | grep -ioe ' [0-9]\.[0-9]*' -m 1
;;

esac

