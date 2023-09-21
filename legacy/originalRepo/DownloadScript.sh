#!/bin/bash

mkdir /databases/MAGENTA/MAGENTA_DB/Data/Amplicon_SRR  /databases/MAGENTA/MAGENTA_DB/Data/RNA_S_SRR  /databases/MAGENTA/MAGENTA_DB/Data/WGS_SRR

cd /databases/MAGENTA/MAGENTA_DB/Data/Amplicon_SRR && chmod a+x /databases/MAGENTA/MAGENTA_DB/Scripts/amplicon.sh && nohup sh /databases/MAGENTA/MAGENTA_DB/Scripts/amplicon.sh > /databases/MAGENTA/MAGENTA_DB/Metadata/amplicon_nohup 2>&1 &

cd /databases/MAGENTA/MAGENTA_DB/Data/RNA_S_SRR && chmod a+x /databases/MAGENTA/MAGENTA_DB/Scripts/rna_seq.sh && nohup sh /databases/MAGENTA/MAGENTA_DB/Scripts/rna_seq.sh > /databases/MAGENTA/MAGENTA_DB/Metadata/rna_seq_nohup 2>&1 &

cd /databases/MAGENTA/MAGENTA_DB/Data/WGS_SRR && chmod a+x /databases/MAGENTA/MAGENTA_DB/Scripts/wgs.sh && nohup sh /databases/MAGENTA/MAGENTA_DB/Scripts/wgs.sh > /databases/MAGENTA/MAGENTA_DB/Metadata/wgs_nohup 2>&1 &

