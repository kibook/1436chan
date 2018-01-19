#!/bin/sh

cd $(dirname "$0")

. ./params.sh

no="$1"
pass=$(sh pass.sh)
date=$(date +%s)

echo "$no	$pass	$date" >> "$DATA_DIR/postpass"
