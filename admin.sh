#!/bin/sh

choice=""

while true
do
	echo "========================="
	echo "= ADMINISTRATOR OPTIONS ="
	echo "========================="
	echo "1) Run setup (full)"
	echo "2) Run setup (quick)"
	echo "3) Delete a post"
	echo "4) Delete a thread"
	echo "5) Create an open sticky"
	echo "6) Create a closed sticky"
	echo "7) Post to a thread"
	echo "8) Wipe"
	echo "q) Quit"

	echo

	read -p "choice: " choice

	echo

	case $choice in
		1) echo "Running setup..."
		   sh setup.sh
		   echo "Setup complete!";;

		2) echo "Running setup (quick)..."
		   sh setup.sh -quick
		   echo "Setup complete!";;

		3) echo "======================="
		   echo "= !!! DELETE POST !!! ="
		   echo "======================="
		   read -p "post #: " post
		   sh deletepost.sh $post
		   if [ $? -eq 0 ]; then echo "Post deleted!"; fi;;

		4) echo "========================="
		   echo "= !!! DELETE THREAD !!! ="
		   echo "========================="
		   read -p "thread #: " thread
		   sh deletethread.sh $thread
		   if [ $? -eq 0 ]; then echo "Thread deleted!"; fi;;

		5) read -p "sticky title: " title
		   sh newsticky.sh $title;;

		6) read -p "sticky title: " title
		   sh newrosticky.sh $title;;

		7) read -p "thread #: " thread
		   sh post.sh $thread
		   if [ $? -eq 0 ]; then echo "Post successful!"; fi;;

		8) sh wipe.sh;;

		q) exit;;

		*) echo "invalid selection";;
	esac

	echo
done
