#!/bin/sh

cd $(dirname "$0")

. ./params.sh

pad=$(printf %70s | tr ' ' _)

for thread in $(ls -td [0-9]* 2>/dev/null)
do
	if [ -e $thread/archive ]
	then
		continue
	fi

	cd $thread

	lastposts=$(ls -v [0-9]* 2>/dev/null | tail -n $LAST_POSTS)
	npost=$(ls [0-9]* 2>/dev/null | wc -l)
	nlast=$(echo -n "$lastposts" | grep -c .)

	if [ $npost -eq 0 ] && [ "$SHOW_EMPTY_THREADS" != y ]
	then
		continue
	fi

	printf "1[thread] %s (%d " "$(cat gophertag)" $npost
	if [ $npost -eq 1 ]
	then
		printf post
	else
		printf posts
	fi
	printf ")\t%s\t%s\t%s\r\n" "$CHAN_ROOT/$thread" "$SERVER_HOST" "$SERVER_PORT"

	i=$((npost - nlast))
	for post in $lastposts
	do
		stamp=$(echo "$post" | cut -d _ -f 1)
		no=$(echo "$post" | cut -d _ -f 2)
		posted=$(date -d @$stamp +"$DATE_FORMAT")
		tripcode=$(grep -E "^${no} .*$" ../tripcodes | sed -r 's/^[0-9]+ (.*)$/\1/')
		postid=$(grep -E "^${no} .*$" ../postids | sed -r 's/^[0-9]+ (.*)$/\1/')

		if test -n "$tripcode" -a -n "$postid"
		then
			header=$(printf "__[%s #%d !%s ID: %s]%s" "$posted" "$no" "$tripcode" "$postid" "$pad" | cut -c1-70)
		elif test -n "$tripcode"
		then
			header=$(printf "__[%s #%d !%s]%s" "$posted" "$no" "$tripcode" "$pad" | cut -c1-70)
		elif test -n "$postid"
		then
			header=$(printf "__[%s #%d ID: %s]%s" "$posted" "$no" "$postid" "$pad" | cut -c1-70)
		else
			header=$(printf "__[%s #%d]%s" "$posted" $no "$pad" | cut -c1-70)
		fi
		phinfo "$header"

		saveifs="$IFS"
		IFS=''
		cat $post | while read -r line
		do
			if echo "$line" | grep -q "	"
			then
				printf "%s\r\n" "$line"
			else
				printf "%s\n" "$line" | fmt -70 | fold -w 70 | while read -r fmtline
				do
					phinfo "$fmtline"
				done
			fi
		done
		IFS="$saveifs"

		phline

		i=$((i + 1))
	done

	if [ "$LAST_POSTS" -gt 0 ] && [ "$nlast" -gt 0 ]
	then
		phline
	fi

	cd ..
done
