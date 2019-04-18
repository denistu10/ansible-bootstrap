#!/bin/bash

### OPTIONS VERIFICATION
if [ -z $1 ]; then
	exit 1
 fi

### PARAMETERS
METRIC="$1"
 
MYSQLADMIN=`which mysqladmin`
CNF="--defaults-file=/root/.my.cnf"
MYSQL=`which mysql`
CACHEFILE="/tmp/mysqlstat.cache"
CACHETTL="55"
 
### RUN
if [ $METRIC = "alive" ]; then
	$MYSQLADMIN $CNF ping | grep -c alive
 exit 0
fi
 
if [ $METRIC = "version" ]; then
 $MYSQL -V
 exit 0
fi

if [ $METRIC = "size" ]; then
	echo "select sum($(case "$4" in both|"") echo "data_length+index_length";; data|index) echo "$4_length";; free) echo "data_free";; esac)) from information_schema.tables$([[ "$2" = "all" || ! "$2" ]] || echo " where table_schema=\"$2\"")$([[ "$3" = "all" || ! "$3" ]] || echo "and table_name=\"$3\"");" | $MYSQL $CNF -N
	# Flexible parameter to determine database or table size. On the frontend side, use keys like mysql.size[zabbix,history,data].
	# Key syntax is mysql[size <database> <table> <type>].
	# Database may be a database name or "all". Default is "all".
	# Table may be a table name or "all". Default is "all".
	# Type may be "data", "index", "free" or "both". Both is a sum of data and index. Default is "both".
	# Database is mandatory if a table is specified. Type may be specified always.
	# Returns value in bytes.
	# 'sum' on data_length or index_length alone needed when we are getting this information for whole database instead of a single table
 exit 0
fi

if [ -s "$CACHEFILE" ]; then
	TIMECACHE=`stat -c"%Z" "$CACHEFILE"`
else
	TIMECACHE=0
fi
 
TIMENOW=`date '+%s'`
if [ "$(($TIMENOW - $TIMECACHE))" -gt "$CACHETTL" ]; then
	$MYSQLADMIN $CNF extended-status > $CACHEFILE || exit 1
fi
 
cat $CACHEFILE | grep -iw "$METRIC" | cut -d'|' -f3
 
exit 0
