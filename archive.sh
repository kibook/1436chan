. ./params.sh

echo $(date +%s) >  $1/archive

rm -f $1/post
rm -f $1/postres
rm -f $1/posthttp
rm -f $1/postfile
rm -f $1/postsplr
rm -f $1/postfileb64
rm -f $1/gophermap

ln template_readonly_gophermap $1/gophermap
