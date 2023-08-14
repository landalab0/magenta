#!/bin/bash

cat /databases/MAGENTA/MAGENTA_DB/Scripts/amplicon.sh | awk -F'/' '{ print $NF }' | while read line; do [ ! -f /databases/MAGENTA/MAGENTA_DB/Data/Amplicon_SRR/$line ] &&  echo $line >> /databases/MAGENTA/MAGENTA_DB/Metadata/amplicon_download_verification; done

cat /databases/MAGENTA/MAGENTA_DB/Scripts/rna_seq.sh | awk -F'/' '{ print $NF }' | while read line; do [ ! -f /databases/MAGENTA/MAGENTA_DB/Data/RNA_S_SRR/$line ] &&  echo $line >> /databases/MAGENTA/MAGENTA_DB/Metadata/rna_seq_download_verification; done

cat /databases/MAGENTA/MAGENTA_DB/Scripts/wgs.sh | awk -F'/' '{ print $NF }' | while read line; do [ ! -f /databases/MAGENTA/MAGENTA_DB/Data/WGS_SRR/$line ] &&  echo $line >> /databases/MAGENTA/MAGENTA_DB/Metadata/wgs_download_verification; done

if [ -s /databases/MAGENTA/MAGENTA_DB/Metadata/amplicon_download_verification ] ; then while read line; do grep ${line}  /databases/MAGENTA/MAGENTA_DB/Scripts/amplicon.sh >> /databases/MAGENTA/MAGENTA_DB/Scripts/amplicon_download_verification.sh; done < /databases/MAGENTA/MAGENTA_DB/Metadata/amplicon_download_verification ; cd /databases/MAGENTA/MAGENTA_DB/Data/Amplicon_SRR && chmod a+x /databases/MAGENTA/MAGENTA_DB/Scripts/amplicon_download_verification.sh && nohup sh /databases/MAGENTA/MAGENTA_DB/Scripts/amplicon_download_verification.sh > /databases/MAGENTA/MAGENTA_DB/Metadata/amplicon_ver_nohup 2>&1 &; fi

if [ -s /databases/MAGENTA/MAGENTA_DB/Metadata/rna_seq_download_verification ] ; then while read line; do grep ${line}  /databases/MAGENTA/MAGENTA_DB/Scripts/rna_seq.sh >> /databases/MAGENTA/MAGENTA_DB/Scripts/rna_seq_download_verification.sh; done < /databases/MAGENTA/MAGENTA_DB/Metadata/rna_seq_download_verification ; cd /databases/MAGENTA/MAGENTA_DB/Data/RNA_S_SRR && chmod a+x /databases/MAGENTA/MAGENTA_DB/Scripts/rna_seq_download_verification.sh && nohup sh /databases/MAGENTA/MAGENTA_DB/Scripts/rna_seq_download_verification.sh > /databases/MAGENTA/MAGENTA_DB/Metadata/rna_seq_ver_nohup 2>&1 &; fi

if [ -s /databases/MAGENTA/MAGENTA_DB/Metadata/wgs_download_verification ] ; then while read line; do grep ${line}  /databases/MAGENTA/MAGENTA_DB/Scripts/wgs.sh >> /databases/MAGENTA/MAGENTA_DB/Scripts/wgs_download_verification.sh; done < /databases/MAGENTA/MAGENTA_DB/Metadata/wgs_download_verification ; cd /databases/MAGENTA/MAGENTA_DB/Data/WGS_SRR && chmod a+x /databases/MAGENTA/MAGENTA_DB/Scripts/wgs_download_verification.sh && nohup sh /databases/MAGENTA/MAGENTA_DB/Scripts/wgs_download_verification.sh > /databases/MAGENTA/MAGENTA_DB/Metadata/wgs_ver_nohup 2>&1 &; fi
