#!/bin/bash

nums_exp='^[0-9]+$'

cnt=$1
sz=$2

echo "arg to $cnt $sz"

if [[ (! $cnt =~ $nums_exp) || (! $sz =~ $nums_exp) ]] ; then
	echo "Zly typ arg"
	exit 1
fi

for (( i = cnt; i > 0; i--  )); do
	d=$(head -c 128 /dev/urandom)
	d=$(echo $d | tr -d '\0')
	num=$(printf "%d" "'$d")
	num=$(($num % sz))
	echo "$num"
done

