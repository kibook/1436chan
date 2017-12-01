thread=$1

if [ ! "$thread" ]
then
	echo "Thread does not exist"
	exit 1
fi

rm -r $thread

sh updatethreadcache.sh > threadcache
