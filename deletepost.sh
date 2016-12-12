. ./params.sh

rm -f [0-9]*/$1
rm -f sticky_[0-9]*/$1
rm -f "$CHAN_ARCHIVE"/[0-9]*/$1
rm -f "$UPLOADS"/[0-9]*/$1
rm -f "$UPLOADS"/[0-9]*/$1.*
rm -f "$UPLOADS"/sticky_[0-9]*/$1
rm -f "$UPLOADS"/sticky_[0-9]*/$1.*
