thread="$1"

stamp=$(date +%s)
no=$(($(ls [0-9]*/[0-9]* | wc -l) + 1))
post="$stamp"_"$no"

touch $thread/$post
vi $thread/$post
