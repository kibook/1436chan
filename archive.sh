. ./params.sh

rm $1/post
rm $1/postres
rm $1/posthttp
rm $1/postfile
rm $1/postsplr
rm $1/gophermap
ln template_archive_gophermap $1/gophermap

mv $1 "$CHAN_ARCHIVE"/
