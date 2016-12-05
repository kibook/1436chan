#!/bin/bash

mv $1 sticky_$1
rm $1/gophermap
ln template_rosticky_gophermap $1/gophermap
rm sticky_$1/post.sh
