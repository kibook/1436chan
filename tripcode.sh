#!/bin/sh

SALT_DIR=$1
PASS=$2

generate_salt() {
	tr -cd 'A-Za-z0-9' < /dev/urandom | head -c 256
}

HASH=$(printf '%s' "$PASS" | sha256sum | cut -d ' ' -f 1)

if test -e "${SALT_DIR}/${HASH}"
then
	read SALT < "${SALT_DIR}/${HASH}"
else
	SALT=$(generate_salt)
	echo "$SALT" > "${SALT_DIR}/${HASH}"
fi

printf '%s' "${PASS}${SALT}" | sha256sum | cut -c 1-10
