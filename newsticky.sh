#!/bin/bash

timestamp=`date +%s`

mkdir sticky_$timestamp
chmod g+w sticky_$timestamp
ln template_gophermap sticky_$timestamp/gophermap
ln template_post sticky_$timestamp/post
ln template_postres sticky_$timestamp/postres
ln template_posthttp sticky_$timestamp/posthttp
ln template_postfile sticky_$timestamp/postfile
ln template_postsplr sticky_$timestamp/postsplr
ln template_postfileb64 sticky_$timestamp/postfileb64
echo "$@" > sticky_$timestamp/gophertag
