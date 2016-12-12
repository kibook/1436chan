#!/bin/bash

mv $1 sticky_$1

mkdir "$UPLOADS/sticky_$1"
chmod g+w "$UPLOADS/sticky_$1"
