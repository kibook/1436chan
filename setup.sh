# Setup params.sh

if [ -e "params.sh" ]
then
	. ./params.sh
	DEFAULT_SERVER_HOST="$SERVER_HOST"
	DEFAULT_SERVER_PORT="$SERVER_PORT"
	DEFAULT_CHAN_ROOT="$CHAN_ROOT"
	DEFAULT_MAX_THREADS=$MAX_THREADS
	DEFAULT_MAX_TITLELEN=$MAX_TITLELEN
	DEFAULT_MAX_POSTS=$MAX_POSTS
	DEFAULT_MAX_POSTLEN=$MAX_POSTLEN
	DEFAULT_ENABLE_ARCHIVE=$ENABLE_ARCHIVE
	DEFAULT_DATE_FORMAT="$DATE_FORMAT"
	DEFAULT_SHOW_EMPTY_THREADS=$SHOW_EMPTY_THREADS
	DEFAULT_LAST_POSTS=$LAST_POSTS
	DEFAULT_MAX_UPLOAD=$MAX_UPLOAD
	DEFAULT_MAX_IMAGE=$MAX_IMAGE
	DEFAULT_DATA_DIR=$DATA_DIR
	DEFAULT_DELETE_TIME=$DELETE_TIME
else
	DEFAULT_SERVER_HOST=localhost
	DEFAULT_SERVER_PORT=70
	DEFAULT_CHAN_ROOT=/$(basename $(pwd))
	DEFAULT_MAX_THREADS=15
	DEFAULT_MAX_TITLELEN=40
	DEFAULT_MAX_POSTS=0
	DEFAULT_MAX_POSTLEN=256
	DEFAULT_ENABLE_ARCHIVE=y
	DEFAULT_DATE_FORMAT='%Y-%m-%d(%a)%H:%M:%S'
	DEFAULT_SHOW_EMPTY_THREADS=y
	DEFAULT_LAST_POSTS=3
	DEFAULT_MAX_UPLOAD=1000000
	DEFAULT_MAX_IMAGE=5000x5000
	DEFAULT_DATA_DIR=/var/1436chan
	DEFAULT_DELETE_TIME=600
fi

if [ "$1" != "-quick" ]
then
	read -p "Hostname of the server [$DEFAULT_SERVER_HOST]: " SERVER_HOST
	read -p "Port of the server [$DEFAULT_SERVER_PORT]: " SERVER_PORT
	read -p "Selector for the board [$DEFAULT_CHAN_ROOT]: " CHAN_ROOT
	read -p "Max threads [$DEFAULT_MAX_THREADS]: " MAX_THREADS
	read -p "Max thread title length [$DEFAULT_MAX_TITLELEN]: " MAX_TITLELEN
	read -p "Max posts [$DEFAULT_MAX_POSTS]: " MAX_POSTS
	read -p "Max post length [$DEFAULT_MAX_POSTLEN]: " MAX_POSTLEN
	read -p "Enable archive? (y/n) [y]: " ENABLE_ARCHIVE
	read -p "Date format [$DEFAULT_DATE_FORMAT]: " DATE_FORMAT
	read -p "Show empty threads (y/n) [$DEFAULT_SHOW_EMPTY_THREADS]: " SHOW_EMPTY_THREADS
	read -p "Last posts to show [$DEFAULT_LAST_POSTS]: " LAST_POSTS
	read -p "Enable uploading of files? (y/n) [y]: " ENABLE_UPLOAD

	if [ ! "$ENABLE_UPLOAD" = "n" ]
	then
		read -p "Maximum uploaded file size (bytes) [$DEFAULT_MAX_UPLOAD]: " MAX_UPLOAD
	else
		MAX_UPLOAD=0
	fi

	read -p "Maximum image dimensions (WxH) [$DEFAULT_MAX_IMAGE]: " MAX_IMAGE
	read -p "Data directory [$DEFAULT_DATA_DIR]: " DATA_DIR
	read -p "Time limit to delete posts [$DEFAULT_DELETE_TIME]: " DELETE_TIME
fi

if [ -z "$SERVER_HOST" ]; then SERVER_HOST="$DEFAULT_SERVER_HOST"; fi
if [ -z "$SERVER_PORT" ]; then SERVER_PORT="$DEFAULT_SERVER_PORT"; fi
if [ -z "$CHAN_ROOT" ]; then CHAN_ROOT="$DEFAULT_CHAN_ROOT"; fi
if [ -z "$MAX_THREADS" ]; then MAX_THREADS=$DEFAULT_MAX_THREADS; fi
if [ -z "$MAX_TITLELEN" ]; then MAX_TITLELEN=$DEFAULT_MAX_TITLELEN; fi
if [ -z "$MAX_POSTS" ]; then MAX_POSTS=$DEFAULT_MAX_POSTS; fi
if [ -z "$MAX_POSTLEN" ]; then MAX_POSTLEN=$DEFAULT_MAX_POSTLEN; fi
if [ -z "$ENABLE_ARCHIVE" ]; then ENABLE_ARCHIVE=$DEFAULT_ENABLE_ARCHIVE; fi
if [ -z "$DATE_FORMAT" ]; then DATE_FORMAT="$DEFAULT_DATE_FORMAT"; fi
if [ -z "$SHOW_EMPTY_THREADS" ]; then SHOW_EMPTY_THREADS=$DEFAULT_SHOW_EMPTY_THREADS; fi
if [ -z "$LAST_POSTS" ]; then LAST_POSTS=$DEFAULT_LAST_POSTS; fi
if [ -z "$MAX_UPLOAD" ]; then MAX_UPLOAD=$DEFAULT_MAX_UPLOAD; fi
if [ -z "$MAX_IMAGE" ]; then MAX_IMAGE=$DEFAULT_MAX_IMAGE; fi
if [ -z "$DATA_DIR" ]; then DATA_DIR=$DEFAULT_DATA_DIR; fi
if [ -z "$DELETE_TIME" ]; then DELETE_TIME=$DEFAULT_DELETE_TIME; fi

echo "SERVER_HOST=$SERVER_HOST" > params.sh
echo "SERVER_PORT=$SERVER_PORT" >> params.sh
echo "CHAN_ROOT=$CHAN_ROOT" >> params.sh
echo "MAX_THREADS=$MAX_THREADS" >> params.sh
echo "MAX_TITLELEN=$MAX_TITLELEN" >> params.sh
echo "MAX_POSTS=$MAX_POSTS" >> params.sh
echo "MAX_POSTLEN=$MAX_POSTLEN" >> params.sh
echo "ENABLE_ARCHIVE=$ENABLE_ARCHIVE" >> params.sh
echo "DATE_FORMAT='$DATE_FORMAT'" >> params.sh
echo "SHOW_EMPTY_THREADS=$SHOW_EMPTY_THREADS" >> params.sh
echo "LAST_POSTS=$LAST_POSTS" >> params.sh
echo "MAX_UPLOAD=$MAX_UPLOAD" >> params.sh
echo "MAX_IMAGE=$MAX_IMAGE" >> params.sh
echo "DATA_DIR=$DATA_DIR" >> params.sh
echo "DELETE_TIME=$DELETE_TIME" >> params.sh

# root permissions
chmod -f g+w .
chmod -f g+s .

# setup state files
if [ ! -e threads ]
then
	echo 0 > threads
fi
if [ ! -e posts ]
then
	echo 0 > posts
fi
chmod -f g+w threads posts

chmod -Rf g+w "$DATA_DIR"
chmod -f g+s "$DATA_DIR"

# thread permissions
chmod -f g+w template_*
chmod -f g+s [0-9]*
chmod -f g+w [0-9]*
chmod -f g+s sticky_[0-9]*
chmod -f g+w sticky_[0-9]*

# fix thread links
for thread in $(ls -dtr [0-9]* 2>/dev/null)
do
	rm -f $thread/gophermap

	if [ -e $thread/post ]
	then
		rm -f $thread/post
		rm -f $thread/postlink
		rm -f $thread/postfile
		rm -f $thread/postsplr
		rm -f $thread/postfileb64
		rm -f $thread/postb64

		ln template_post $thread/post
		ln template_postlink $thread/postlink
		ln template_postfile $thread/postfile
		ln template_postsplr $thread/postsplr
		ln template_postfileb64 $thread/postfileb64
		ln template_postb64 $thread/postb64

		ln template_gophermap $thread/gophermap
	else
		ln template_readonly_gophermap $thread/gophermap
	fi

	rm -f $thread/postcache

	sh updatepostcache.sh $thread > $thread/postcache

	touch $thread
done

for thread in $(ls -dtr sticky_* 2>/dev/null)
do
	rm -f $thread/gophermap

	if [ -e $thread/post ]
	then
		rm -f $thread/post
		rm -f $thread/postlink
		rm -f $thread/postfile
		rm -f $thread/postsplr
		rm -f $thread/postfileb64
		rm -f $thread/postb64

		ln template_post $thread/post
		ln template_postlink $thread/postlink
		ln template_postfile $thread/postfile
		ln template_postsplr $thread/postsplr
		ln template_postfileb64 $thread/postfileb64
		ln template_postb64 $thread/postb64

		ln template_gophermap $thread/gophermap
	else
		ln template_readonly_gophermap $thread/gophermap
	fi

	rm -f $thread/postcache

	sh updatepostcache.sh $thread > $thread/postcache

	touch $thread
done

sh updatethreadcache.sh > threadcache

# postcache permissions
chmod -f g+w [0-9]*/postcache
chmod -f g+w sticky_[0-9]*/postcache
chmod -f g+w threadcache
