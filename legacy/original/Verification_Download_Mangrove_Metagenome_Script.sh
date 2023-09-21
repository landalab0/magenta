//Script#3

#!/bin/bash

cat ~/Scripts/amplicon.sh | awk -F'/' '{ print $NF }' | while read line; do [ ! -f ~/Data/Amplicon_SRR/$line ] &&  echo $line >> ~/Metadata/amplicon_download_verification; done

cat ~/Scripts/rna_seq.sh | awk -F'/' '{ print $NF }' | while read line; do [ ! -f ~/Data/RNA_S_SRR/$line ] &&  echo $line >> ~/Metadata/rna_seq_download_verification; done

cat ~/Scripts/wgs.sh | awk -F'/' '{ print $NF }' | while read line; do [ ! -f ~/Data/WGS_SRR/$line ] &&  echo $line >> ~/Metadata/wgs_download_verification; done

if [ -s ~/Metadata/amplicon_download_verification ] ; then while read line; do grep ${line}  ~/Scripts/amplicon.sh >> ~/Scripts/amplicon_download_verification.sh; done < ~/Metadata/amplicon_download_verification ; cd ~/Data/Amplicon_SRR && nohup ~/Scripts/amplicon_download_verification.sh & > ~/Metadata/amplicon_ver_nohup ; fi

if [ -s ~/Metadata/rna_seq_download_verification ] ; then while read line; do grep ${line}  ~/Scripts/rna_seq.sh >> ~/Scripts/rna_seq_download_verification.sh; done < ~/Metadata/rna_seq_download_verification ; cd ~/Data/RNA_S_SRR && nohup ~/Scripts/rna_seq_download_verification.sh & > ~/Metadata/rna_seq_ver_nohup ; fi

if [ -s ~/Metadata/wgs_download_verification ] ; then while read line; do grep ${line}  ~/Scripts/wgs.sh >> ~/Scripts/wgs_download_verification.sh; done < ~/Metadata/wgs_download_verification ; cd ~/Data/WGS_SRR && nohup ~/Scripts/wgs_download_verification.sh & > ~/Metadata/wgs_ver_nohup ; fi
