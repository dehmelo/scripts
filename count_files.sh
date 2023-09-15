#!/bin/bash
read -p "Enter the directory path: " dir
count=$(ls -1 $dir | wc -l)
echo "The $dir directory contains $count files."
