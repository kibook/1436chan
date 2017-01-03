thread=$(ls [0-9]*_$1 2>/dev/null)

if [ ! "$thread" ]
then
	thread=$(ls sticky_[0-9]*_$1 2>/dev/null)
fi

if [ ! "$thread" ]
then
	echo "Thread does not exist"
	exit 1
fi

rm -r $thread
