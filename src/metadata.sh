#!/bin/bash

# Directories and make
SEQUENCES_DIR=~/Desktop/MAGENTA/data/sequences
METADATA_DIR=~/Desktop/MAGENTA/data/metadata
SCRIPTS_DIR=~/Desktop/MAGENTA/data/scripts
mkdir -p $SEQUENCES_DIR $METADATA_DIR $SCRIPTS_DIR

# URL
ENA_SEARCH_URL="https://www.ebi.ac.uk/ena/portal/api/search?result=read_run&fields=fastq_ftp&query=run_accession="
ENA_PROJECT_URL="https://www.ebi.ac.uk/ena/browser/api/tsv/textsearch?domain=project&query=mangrove%20metagenome&format=tsv"

# Output filee names
STUDY_METADATA=$METADATA_DIR/read_study_metadata
RUN_METADATA=$METADATA_DIR/read_run_metadata

# Fields
SEARCH_FIELDS="study_accession,library_strategy,collection_date,country,lat,lon,depth,instrument_platform,instrument_model"

# Get study metadata (read_study)
curl "$ENA_PROJECT_URL" | cut -f1 | while read -r line; do
    line=$(echo $line | tr -d '"')
    curl "https://www.ebi.ac.uk/ena/portal/api/search?result=read_study&query=study_accession=$line&fields=$SEARCH_FIELDS" >> $STUDY_METADATA
done

# Get read run metadata (read_run)
sed '/accession/d' $STUDY_METADATA | cut -f1 | uniq | while read -r line; do
    curl "https://www.ebi.ac.uk/ena/portal/api/search?result=read_run&query=study_accession=$line&fields=$SEARCH_FIELDS" >> $RUN_METADATA
done

# Function to generate the download cmd files
generate_script () {
    local library_strategy=$1
    local output_script=$2
    awk -v library_strategy="${library_strategy}" '$0 !~ /accession/ && $0 ~ library_strategy {print $1}' $RUN_METADATA | while read -r line; do
        curl "${ENA_SEARCH_URL}${line}&fields=fastq_ftp" | cut -f2 | tr ';' '\n' | sed -e 's/ftp/wget ftp/g' -e '/fastq_wget/d' >> $output_script
    done
}

# Generate download scripts
generate_script "WGS" "$SCRIPTS_DIR/wgs.sh"
generate_script "AMPLICON" "$SCRIPTS_DIR/amplicon.sh"
generate_script "RNA-Seq" "$SCRIPTS_DIR/rna_seq.sh"

echo "metadata.sh done";