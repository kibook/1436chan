#!/bin/sh

mv $1 sticky_$1
rm -f $1/gophermap
ln template_readonly_gophermap $1/gophermap
rm -f sticky_$1/post
rm -f sticky_$1/postlink
rm -f sticky_$1/postfile
rm -f sticky_$1/postsplr
rm -f sticky_$1/postfileb64
rm -f sticky_$1/postb64
