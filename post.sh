#!/bin/bash
timestamp=`date +%s`

thread="$1"

if [ ! "$thread" ]
then
	thread="."
fi

touch $thread/$timestamp
"${EDITOR:-vi}" $thread/$timestamp
