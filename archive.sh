. ./params.sh

rm $1/post
rm $1/postres
rm $1/posthttp
rm $1/postfile
rm $1/postsplr
rm $1/gophermap
ln template_archive_gophermap $1/gophermap

for post in $(ls $1/[0-9]* 2>/dev/null)
do
	comment=$(cat post | sed "s/\\$CHAN_ROOT\/$1/\\$CHAN_ROOT\/$CHAN_ARCHIVE\/$1/g")
	echo "$comment" > $post
done

mv $1 "$CHAN_ARCHIVE"/
