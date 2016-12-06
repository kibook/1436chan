#!/bin/bash

timestamp=`date +%s`

mkdir sticky_$timestamp
chmod g+w sticky_$timestamp
ln template_gophermap sticky_$timestamp/gophermap
ln template_post sticky_$timestamp/post
echo "$@" > sticky_$timestamp/gophertag
