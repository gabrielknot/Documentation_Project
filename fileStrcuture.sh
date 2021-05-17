#!/bin/bash
echo "" > datastructure
#while read p; do
#	echo "$p" > datastructure
	tree ~/kubernetes-project/learning_ansible/kubernetes-setup/roles/$p > datastructure
while IFS="" read -r p || [ -n "$p" ]
do
  printf '%s\n' "$p" > datastructure
  tree ~/kubernetes-project/learning_ansible/kubernetes-setup/roles/$p > datastructure
done <roles.txt 
