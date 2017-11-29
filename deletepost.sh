#!/bin/sh

post=$(ls [0-9]*/[0-9]*_$1 2>/dev/null)

if [ ! "$post" ]
then
	post=$(ls sticky_[0-9]*_[0-9]*/[0-9]*_$1 2>/dev/null)
fi

if [ ! "$post" ]
then
	echo "Post does not exist"
	exit 1
fi

thread=$(echo $post | cut -f 1 -d /)

rm $post
./updatepostcache $thread > $thread/postcache
