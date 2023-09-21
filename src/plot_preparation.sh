#!/bin/bash

#--- This script is super dirty, refactor later

# Checks
if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi
filename=$1
keyword="study_accession"

# I want to preserve the header, so read only the first line of the file and save
read -r firstLine < "$1"
echo "$firstLine" > tmpfile

temp_file=$(mktemp)
grep -v "$keyword" "$filename" > "$temp_file"
# Replace the original file with the temp file and append to the header
cat "$temp_file" >> tmpfile
METADATA_PATH=~/Desktop/MAGENTA/data/metadata
mv tmpfile "$METADATA_PATH/plot_metadata"

rm -f "$temp_file"
rm -f tmpfile

cat "$METADATA_PATH/plot_metadata" | cut -f6 | awk -F ':' '{print $1}' > "$METADATA_PATH/country_only"
cat "$METADATA_PATH/country_only" | sort | uniq | sed '/country/d' | sed '/^$/d' > "$METADATA_PATH/country_names"

fgrep -of "$METADATA_PATH/country_names" "$METADATA_PATH/country_only" | sort | uniq -c | awk '{print $2 " " $1}' > "$METADATA_PATH/country_count"

echo "Graphical parsing done"