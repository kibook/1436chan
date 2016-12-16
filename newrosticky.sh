timestamp=`date +%s`

stamp=$(date +%s)
no=$(($(ls -d [0-9]* | wc -l) + 1))
thread="$stamp"_"$no"

mkdir sticky_$thread
ln template_readonly_gophermap sticky_$thread/gophermap
echo "$@" > sticky_$thread/gophertag
