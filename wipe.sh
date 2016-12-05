#!/bin/bash

echo "WARNING: THIS WILL DELETE EVERYTHING!"
read -p "Are you sure you want to continue? y/n [n]: " CONT

if [ "$CONT" = "y" ]
then
	rm -rf [0-9]*
	rm -rf sticky_*
	rm -rf archive/[0-9]*
else
	echo "Aborted."
fi
