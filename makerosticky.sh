#!/bin/bash

mv $1 sticky_$1
rm $1/gophermap
ln template_rosticky_gophermap $1/gophermap
rm sticky_$1/post
rm sticky_$1/postres
rm sticky_$1/posthttp
rm sticky_$1/postfile
rm sticky_$1/postsplr
