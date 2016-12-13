#!/bin/bash

mv $1 sticky_$1
rm -f $1/gophermap
ln template_readonly_gophermap $1/gophermap
rm -f sticky_$1/post
rm -f sticky_$1/postres
rm -f sticky_$1/posthttp
rm -f sticky_$1/postfile
rm -f sticky_$1/postsplr
