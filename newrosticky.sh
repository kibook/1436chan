timestamp=`date +%s`

stamp=$(date +%s)

if [ -e threads ]
then
	no=$(cat threads)
else
	no=0
fi
no=$(($no + 1))

thread="$stamp"_"$no"

mkdir sticky_$thread
ln template_readonly_gophermap sticky_$thread/gophermap
echo "$@" > sticky_$thread/gophertag
