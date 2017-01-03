thread=$(ls -d [0-9]*_$1 2>/dev/null)

if [ ! "$thread" ]
then
	thread=$(ls -d sticky_[0-9]*_$1 2>/dev/null)
fi

if [ ! "$thread" ]
then
	echo "Thread does not exist"
	exit 1
fi

stamp=$(date +%s)

if [ -e posts ]
then
	no=$(cat posts)
else
	no=0
fi
no=$(($no + 1))

post="$stamp"_"$no"

touch $thread/$post
vi $thread/$post
./updatepostcache $thread $post >> $thread/postcache

echo $no > posts
