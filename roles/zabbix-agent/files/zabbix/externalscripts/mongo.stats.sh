#!/bin/bash

dataFile="/tmp/mongo-plugin.php_local.data"

case $1 in
	cron)
		/usr/bin/php /etc/zabbix/externalscripts/mongo-plugin.php -h 127.0.0.1 -p 27017 -z local
	;;

	globalLock_currentQueue_total)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	globalLock_currentQueue_readers)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	globalLock_currentQueue_writers)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	indexCounters_accesses)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	indexCounters_hits)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	indexCounters_misses)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	cursors_totalOpen)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	cursors_timedOut)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;
    indexesSize)
        cat $dataFile | grep $1 | awk '{print $3}'
    ;;

##
	opcounters_insert)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	opcounters_query)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	opcounters_update)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	opcounters_delete)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	opcounters_getmore)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	opcounters_command)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	backgroundFlushing_flushes)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	mem_mapped)
	        cat $dataFile | grep $1 | awk '{print $3}'
	;;

	mem_virtual)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	mem_resident)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	extra_info_page_faults)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

	connections_current)
		cat $dataFile | grep $1 | awk '{print $3}'
	;;

esac