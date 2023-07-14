//Script#0

#!/bin/bash

mkdir /databases/MAGENTA/MAGENTA_DB

mkdir /databases/MAGENTA/MAGENTA_DB/Data /databases/MAGENTA/MAGENTA_DB/Metadata /databases/MAGENTA/MAGENTA_DB/Scripts

chmod a+x /databases/MAGENTA/MAGENTA_EXE/Search_and_ClassifScript.sh /databases/MAGENTA/MAGENTA_EXE/DownloadScript.sh /databases/MAGENTA/MAGENTA_EXE/VerificationScript.sh

nohup sh /databases/MAGENTA/MAGENTA_EXE/Search_and_ClassifScript.sh  > /databases/MAGENTA/MAGENTA_EXE/Search_and_Classif_nohup 2>&1 &

nohup sh /databases/MAGENTA/MAGENTA_EXE/DownloadScript.sh  > /databases/MAGENTA/MAGENTA_EXE/Download_nohup 2>&1 &

nohup sh /databases/MAGENTA/MAGENTA_EXE/VerificationScript.sh  > /databases/MAGENTA/MAGENTA_EXE/Verification_nohup 2>&1 &





