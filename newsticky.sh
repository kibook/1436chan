#!/bin/sh

stamp=$(date +%s)

if [ -e posts ]
then
	no=$(cat posts)
else
	no=0
fi
no=$(($no + 1))

thread="$stamp"_"$no"

mkdir sticky_$thread
chmod g+w sticky_$thread
ln template_gophermap sticky_$thread/gophermap
ln template_post sticky_$thread/post
ln template_postlink sticky_$thread/postlink
ln template_postfile sticky_$thread/postfile
ln template_postsplr sticky_$thread/postsplr
ln template_postfileb64 sticky_$thread/postfileb64
ln template_quotepost sticky_$thread/quotepost
echo "$@" > sticky_$thread/gophertag
