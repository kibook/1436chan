#!/bin/sh

thread=$1

if [ ! "$thread" ]
then
	echo "Thread does not exist"
	exit 1
fi

stamp=$(date +%s)

if [ -e posts ]
then
	no=$(cat posts)
else
	no=0
fi
no=$(($no + 1))

post="$stamp"_"$no"

touch $thread/$post
vi $thread/$post
sh updatepostcache.sh $thread $post >> $thread/postcache

if test "$MAX_RSS_ITEMS" -gt 0
then
	sh updaterss.sh $id $no "$(cat $thread/$post)"
fi

echo $no > posts

sh updatethreadcache.sh > threadcache
