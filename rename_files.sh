#!/bin/bash
read -p "Enter the directory path: " dir
for file in "$dir"/*.md; do
  mv "$file" "${file%.md}_old.md"
done
echo "Files renamed successfully."
