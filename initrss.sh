#!/bin/sh

. ./params.sh

cp -n template_rss.xml rss.xml

xmlstarlet ed -L \
	-u /rss/channel/title -v "$SERVER_HOST$CHAN_ROOT" \
	-u /rss/channel/link -v "gopher://$SERVER_HOST:$SERVER_PORT/1$CHAN_ROOT" \
	-u /rss/channel/description -v "$SERVER_HOST$CHAN_ROOT" \
	rss.xml
