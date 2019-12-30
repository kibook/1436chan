#!/bin/sh

if ! test -e ./params.sh
then
	exit 1
fi

. ./params.sh

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

# post id
if test "$ENABLE_POST_IDS" = y
then
	postid=$(sh tripcode.sh "$SALT_DIR" "$SERVER_HOST")
	echo "${no} ${postid}" >> postids
fi

# tripcode
read -p "Tripcode: " password
if test -n "$password"
then
	tripcode=$(sh tripcode.sh "$SALT_DIR" "$password")
	echo "${no} ${tripcode}" >> tripcodes
fi

touch $thread/$post
vi $thread/$post
sh updatepostcache.sh $thread $post >> $thread/postcache

if test "$MAX_RSS_ITEMS" -gt 0
then
	sh updaterss.sh $thread $no "$(cat $thread/$post)"
fi

echo $no > posts

sh updatethreadcache.sh > threadcache
