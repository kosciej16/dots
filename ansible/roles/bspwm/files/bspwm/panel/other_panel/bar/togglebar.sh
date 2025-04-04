#!/bin/sh

bardpid=$(pgrep 'dzenbardaemon')
echo $bardpid

kill -s USR1 $bardpid
pkill -P $bardpid sleep
