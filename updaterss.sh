#!/bin/sh

thread="$1"
postno="$2"
comment="$3"

cd $(dirname "$0")

. ./params.sh

xmlstarlet ed -L -d "/rss/channel/item[position() >= $MAX_RSS_ITEMS]" rss.xml

if xmlstarlet sel -Q -t -c /rss/channel/item rss.xml
then
	xmlstarlet ed -L \
		-i /rss/channel/item[1] -t elem -n item \
		-s /rss/channel/item[1] -t elem -n title -v "Reply to: $(cat $thread/gophertag) (post #$postno)" \
		-s /rss/channel/item[1] -t elem -n link -v "gopher://$SERVER_HOST:$SERVER_PORT/1$CHAN_ROOT/$thread" \
		-s /rss/channel/item[1] -t elem -n description -v "$comment" \
		-s /rss/channel/item[1] -t elem -n pubDate -v "$(date -R)" \
		-s /rss/channel/item[1] -t elem -n guid -v "$(uuid)" \
		-i /rss/channel/item[1]/guid -t attr -n isPermaLink -v 'false' \
		rss.xml
else
	xmlstarlet ed -L \
		-s /rss/channel -t elem -n item \
		-s /rss/channel/item[1] -t elem -n title -v "Reply to: $(cat $thread/gophertag) (post #$postno)" \
		-s /rss/channel/item[1] -t elem -n link -v "gopher://$SERVER_HOST:$SERVER_PORT/1$CHAN_ROOT/$thread" \
		-s /rss/channel/item[1] -t elem -n description -v "$comment" \
		-s /rss/channel/item[1] -t elem -n pubDate -v "$(date -R)" \
		-s /rss/channel/item[1] -t elem -n guid -v "$(uuid)" \
		-i /rss/channel/item[1]/guid -t attr -n isPermaLink -v 'false' \
		rss.xml
fi
