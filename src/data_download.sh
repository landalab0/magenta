#!/bin/bash

<<seal
declare -A data_scripts=(
    ["Amplicon_SRR"]="amplicon.sh"
    ["RNA_S_SRR"]="rna_seq.sh"
    ["WGS_SRR"]="wgs.sh"
)

for data in "${!data_scripts[@]}"; do
    mkdir -p "~/Data/${data}"
    nohup "~/Scripts/${data_scripts[$data]}" &> "~/Metadata/${data}_nohup"
done
seal