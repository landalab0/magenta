#!/bin/bash

path=/databases/MAGENTA

mkdir $path/MAGENTA_DB

mkdir $path/MAGENTA_DB/Data $path/MAGENTA_DB/Metadata $path/MAGENTA_DB/Scripts

chmod a+x $path/magenta/Search_and_ClassifScript.sh $path/magenta/DownloadScript.sh $path/magenta/VerificationScript.sh

nohup sh $path/magenta/Search_and_ClassifScript.sh  > $path/magenta/Search_and_Classif_nohup 2>&1 & && nohup sh $path/magenta/DownloadScript.sh  > $path/magenta/Download_nohup 2>&1 & && nohup sh $path/magenta/VerificationScript.sh  > $path/magenta/Verification_nohup 2>&1 &





