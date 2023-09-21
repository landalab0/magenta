//Script#2

#!/bin/bash

mkdir ~/Data/Amplicon_SRR  ~/Data/RNA_S_SRR  ~/Data/WGS_SRR

cd ~/Data/Amplicon_SRR && nohup ~/Scripts/amplicon.sh & > ~/Metadata/amplicon_nohup

cd ~/Data/RNA_S_SRR && nohup ~/Scripts/rna_seq.sh & > ~/Metadata/rna_seq_nohup

cd ~/Data/WGS_SRR && nohup ~/Scripts/wgs.sh & > ~/Metadata/wgs_nohup

