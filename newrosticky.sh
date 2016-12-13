#!/bin/bash

timestamp=`date +%s`

mkdir sticky_$timestamp
ln template_readonly_gophermap sticky_$timestamp/gophermap
echo "$@" > sticky_$timestamp/gophertag
