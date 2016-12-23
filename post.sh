thread="$1"

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
