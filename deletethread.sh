. ./params.sh

id=$(basename "$1")

rm -rf "$1"
rm -rf "$UPLOADS/$id"
