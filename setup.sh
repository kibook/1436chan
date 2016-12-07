# Setup params.sh

if [ -e "params.sh" ]
then
	. ./params.sh
	DEFAULT_CHAN_ROOT="$CHAN_ROOT"
	DEFAULT_MAX_THREADS=$MAX_THREADS
	DEFAULT_MAX_TITLELEN=$MAX_TITLELEN
	DEFAULT_MAX_POSTLEN=$MAX_POSTLEN
	DEFAULT_CHAN_ARCHIVE="$CHAN_ARCHIVE"
	DEFAULT_DATE_FORMAT="$DATE_FORMAT"
	DEFAULT_SHOW_EMPTY_THREADS=$SHOW_EMPTY_THREADS
	DEFAULT_LAST_POSTS=$LAST_POSTS
	DEFAULT_MAX_UPLOAD=$MAX_UPLOAD
else
	DEFAULT_CHAN_ROOT=/$(basename $(pwd))
	DEFAULT_MAX_THREADS=15
	DEFAULT_MAX_TITLELEN=40
	DEFAULT_MAX_POSTLEN=256
	DEFAULT_CHAN_ARCHIVE=archive
	DEFAULT_DATE_FORMAT='%Y-%m-%d(%a)%H:%M:%S'
	DEFAULT_SHOW_EMPTY_THREADS=y
	DEFAULT_LAST_POSTS=3
	DEFAULT_MAX_UPLOAD=1000000
fi

read -p "Selector for the board [$DEFAULT_CHAN_ROOT]: " CHAN_ROOT
read -p "Max threads [$DEFAULT_MAX_THREADS]: " MAX_THREADS
read -p "Max thread title length [$DEFAULT_MAX_TITLELEN]: " MAX_TITLELEN
read -p "Max post length [$DEFAULT_MAX_POSTLEN]: " MAX_POSTLEN

read -p "Enable archive? (y/n) [y]: " ENABLE_ARCHIVE

if [ ! "$ENABLE_ARCHIVE" = "n" ]
then
	read -p "Archive folder [$DEFAULT_CHAN_ARCHIVE]: " CHAN_ARCHIVE
fi

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

if [ -z "$CHAN_ROOT" ]; then CHAN_ROOT="$DEFAULT_CHAN_ROOT"; fi
if [ -z "$MAX_THREADS" ]; then MAX_THREADS=$DEFAULT_MAX_THREADS; fi
if [ -z "$MAX_TITLELEN" ]; then MAX_TITLELEN=$DEFAULT_MAX_TITLELEN; fi
if [ -z "$MAX_POSTLEN" ]; then MAX_POSTLEN=$DEFAULT_MAX_POSTLEN; fi

if [ ! "$ENABLE_ARCHIVE" = "n" ]
then
	if [ -z "$CHAN_ARCHIVE" ]
	then
		CHAN_ARCHIVE=$DEFAULT_CHAN_ARCHIVE
	fi
fi

if [ -z "$DATE_FORMAT" ]; then DATE_FORMAT="$DEFAULT_DATE_FORMAT"; fi
if [ -z "$SHOW_EMPTY_THREADS" ]; then SHOW_EMPTY_THREADS=$DEFAULT_SHOW_EMPTY_THREADS; fi
if [ -z "$LAST_POSTS" ]; then LAST_POSTS=$DEFAULT_LAST_POSTS; fi
if [ -z "$MAX_UPLOAD" ]; then MAX_UPLOAD=$DEFAULT_MAX_UPLOAD; fi

echo "CHAN_ROOT=$CHAN_ROOT" > params.sh
echo "MAX_THREADS=$MAX_THREADS" >> params.sh
echo "MAX_TITLELEN=$MAX_TITLELEN" >> params.sh
echo "MAX_POSTLEN=$MAX_POSTLEN" >> params.sh
echo "CHAN_ARCHIVE=$CHAN_ARCHIVE" >> params.sh
echo "DATE_FORMAT='$DATE_FORMAT'" >> params.sh
echo "SHOW_EMPTY_THREADS=$SHOW_EMPTY_THREADS" >> params.sh
echo "LAST_POSTS=$LAST_POSTS" >> params.sh
echo "MAX_UPLOAD=$MAX_UPLOAD" >> params.sh

# fix links, setup archive
for thread in $(ls -dtr [0-9]* 2>/dev/null)
do
	rm -f $thread/post
	rm -f $thread/postres
	rm -f $thread/posthttp
	rm -f $thread/postfile
	rm -f $thread/gophermap

	ln template_post $thread/post
	ln template_postres $thread/postres
	ln template_posthttp $thread/posthttp
	ln template_gophermap $thread/gophermap
	ln template_postfile $thread/postfile
done

for thread in $(ls -dtr sticky_* 2>/dev/null)
do
	rm -f $thread/gophermap

	if [ -e $thread/post ]
	then
		rm -f $thread/post
		rm -f $thread/postres
		rm -f $thread/posthttp
		rm -f $thread/postfile

		ln template_post $thread/post
		ln template_postres $thread/postres
		ln template_posthttp $thread/posthttp
		ln template_postfile $thread/postfile
		ln template_postsplr $thread/postsplr

		ln template_gophermap $thread/gophermap
	else
		ln template_rosticky_gophermap $thread/gophermap
	fi
done
		

if [ "$CHAN_ARCHIVE" ]
then
	if [ ! "$CHAN_ARCHIVE" = "$DEFAULT_CHAN_ARCHIVE" ]
	then
		if [ ! -e "$CHAN_ARCHIVE" ]
		then
			mkdir "$CHAN_ARCHIVE"
		fi

		mv "$DEFAULT_CHAN_ARCHIVE"/gophermap "$CHAN_ARCHIVE"/gophermap
		rmdir archive
	fi

	for thread in $(ls -d $CHAN_ARCHIVE/[0-9]* 2>/dev/null)
	do
		rm -f $thread/gophermap
		ln template_archive_gophermap $thread/gophermap
	done
fi

# permissions
chmod g+w .
chmod g+s .
chmod g+w template_*
chmod g+w $CHAN_ARCHIVE
chmod g+s $CHAN_ARCHIVE
chmod g+w [0-9]*
chmod g+w sticky_[0-9]*
