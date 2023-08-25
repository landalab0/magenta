#!/bin/bash

path=/databases

mkdir $path/MAGENTA/MAGENTA_DB

mkdir $path/MAGENTA/MAGENTA_DB/Data $path/MAGENTA/MAGENTA_DB/Metadata $path/MAGENTA/MAGENTA_DB/Scripts

chmod a+x $path/MAGENTA/magenta/Search_and_ClassifScript.sh $path/MAGENTA/magenta/DownloadScript.sh $path/MAGENTA/magenta/VerificationScript.sh

nohup sh $path/MAGENTA/magenta/Search_and_ClassifScript.sh  > $path/MAGENTA/magenta/Search_and_Classif_nohup 2>&1 & && nohup sh $path/MAGENTA/magenta/DownloadScript.sh  > $path/MAGENTA/magenta/Download_nohup 2>&1 & && nohup sh $path/MAGENTA/magenta/VerificationScript.sh  > $path/MAGENTA/magenta/Verification_nohup 2>&1 &





