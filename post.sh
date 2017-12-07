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

echo $no > posts

sh updatethreadcache.sh > threadcache
