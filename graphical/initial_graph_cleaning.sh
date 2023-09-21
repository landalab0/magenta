#!/bin/bash

#--- Refactor and compare

# Checks
if [ $# -ne 2 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi
filename=$2
keyword="run_accession"

# I want to preserve the header, read only the first line of the file and save
read -r firstLine < "$1"
echo "$firstLine" > tmpfile

temp_file=$(mktemp)
grep -v "$keyword" "$filename" > "$temp_file"
# Replace the original file with the temp file and append to the header
cat "$temp_file" >> tmpfile
METADATA_PATH=~/Desktop/test
mv tmpfile "$METADATA_PATH/plot_metadata"

cat "$METADATA_PATH/plot_metadata" | cut -f5 | awk -F ':' '{print $1}' > "$METADATA_PATH/acc_names"
cat "$METADATA_PATH/acc_only" | sort | uniq | sed '/acc/d' | sed '/^$/d' > "$METADATA_PATH/acc_only"

fgrep -of "$METADATA_PATH/acc_names" "$METADATA_PATH/acc_only" | sort | uniq -c | awk '{print $2 " " $1}' > "$METADATA_PATH/acc_only"
