#!/bin/sh

cd $(dirname "$0")

. ./params.sh

no="$1"
pass=$(sh pass.sh)
date=$(date +%s)

sh updatepostpass.sh

echo "$no	$pass	$date" >> "$DATA_DIR/postpass"
