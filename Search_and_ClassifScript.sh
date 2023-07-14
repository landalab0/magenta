//Script#1

#!/bin/bash

curl "https://www.ebi.ac.uk/ena/browser/api/tsv/textsearch?domain=project&query=mangrove%20metagenome&format=tsv"  | cut -f1 | while read line; do curl "https://www.ebi.ac.uk/ena/portal/api/search?result=read_study&query=study_accession=$line&fields=description,collection_date,country" >> /databases/MAGENTA/MAGENTA_DB/Metadata/read_study_metadata; done

sed '/accession/d' /databases/MAGENTA/MAGENTA_DB/Metadata/read_study_metadata | cut -f1 | uniq | while read line; do curl "https://www.ebi.ac.uk/ena/portal/api/search?result=read_run&query=study_accession=$line&fields=study_accession,library_strategy,experiment_title,instrument_platform,instrument_model,location" >> /databases/MAGENTA/MAGENTA_DB/Metadata/read_run; done

sed '/accession/d' /databases/MAGENTA/MAGENTA_DB/Metadata/read_run | grep WGS | cut -f1 | while read line; do curl "https://www.ebi.ac.uk/ena/portal/api/search?result=read_run&query=run_accession=$line&fields=fastq_ftp"; done | cut -f2 | sed 's/;/\n/g' | sed 's/ftp/wget ftp/g'  | sed '/fastq_wget/d' > /databases/MAGENTA/MAGENTA_DB/Scripts/wgs.sh

sed '/accession/d' /databases/MAGENTA/MAGENTA_DB/Metadata/read_run | grep AMPLICON | cut -f1 | while read line; do curl "https://www.ebi.ac.uk/ena/portal/api/search?result=read_run&query=run_accession=$line&fields=fastq_ftp"; done | cut -f2 | sed 's/;/\n/g' | sed 's/ftp/wget ftp/g'  | sed '/fastq_wget/d' > /databases/MAGENTA/MAGENTA_DB/Scripts/amplicon.sh

sed '/accession/d' /databases/MAGENTA/MAGENTA_DB/Metadata/read_run | grep RNA-Seq | cut -f1 | while read line; do curl "https://www.ebi.ac.uk/ena/portal/api/search?result=read_run&query=run_accession=$line&fields=fastq_ftp"; done | cut -f2 | sed 's/;/\n/g' | sed 's/ftp/wget ftp/g'  | sed '/fastq_wget/d' > /databases/MAGENTA/MAGENTA_DB/Scripts/rna_seq.sh
