#!/bin/bash

name_compressed=$(7z l data2 | grep "Name" -A 2 | tail -n 1 | awk "NF{print $NF}")
7z x data2 > /dev/null 2>&1

while true; do
	7z l $name_compressed > /dev/null 2>&1

	if [ "$(echo $?)" == "0" ]; then
 		decompressed_next=$(7z l $name_compressed | grep "Name" -A 2 | tail -n 1 | awk "NF{print $NF}")
		7z x $name_compressed > /dev/null 2>&1 && name_compressed=$decompressed_next
	else
		cat $name_compressed; rm data*
		exit 1
	fi
done
