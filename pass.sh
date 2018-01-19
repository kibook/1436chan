#!/bin/sh

echo "$REMOTE_ADDR" | sha256sum | cut -d' ' -f1
