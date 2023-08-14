#!/bin/bash

mkdir /databases/MAGENTA/MAGENTA_DB

mkdir /databases/MAGENTA/MAGENTA_DB/Data /databases/MAGENTA/MAGENTA_DB/Metadata /databases/MAGENTA/MAGENTA_DB/Scripts

chmod a+x /databases/MAGENTA/magenta/Search_and_ClassifScript.sh /databases/MAGENTA/magenta/DownloadScript.sh /databases/MAGENTA/magenta/VerificationScript.sh

nohup sh /databases/MAGENTA/magenta/Search_and_ClassifScript.sh  > /databases/MAGENTA/magenta/Search_and_Classif_nohup 2>&1 &

nohup sh /databases/MAGENTA/magenta/DownloadScript.sh  > /databases/MAGENTA/magenta/Download_nohup 2>&1 &

nohup sh /databases/MAGENTA/magenta/VerificationScript.sh  > /databases/MAGENTA/magenta/Verification_nohup 2>&1 &





