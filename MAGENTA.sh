//Script#0

Antes de ejecutarlo , obtener permisos de root : sudo su

Ejecutarlo de la siguiente manera:

Primero, Crear carpeta /databases/MAGENTA/MAGENTA_EXE y guardar todos los scripts ahí

Segundo, chmod a+x /databases/MAGENTA/MAGENTA_EXE/MAGENTA.sh

Tercero, nohup sh /databases/MAGENTA/MAGENTA_EXE/MAGENTA.sh > /databases/MAGENTA/MAGENTA_EXE/MAGENTA_DB_nohup 2>&1 &

#!/bin/bash

mkdir /databases/MAGENTA/MAGENTA_DB

mkdir /databases/MAGENTA/MAGENTA_DB/Data /databases/MAGENTA/MAGENTA_DB/Metadata /databases/MAGENTA/MAGENTA_DB/Scripts

chmod a+x /databases/MAGENTA/MAGENTA_EXE/Search_and_ClassifScript.sh /databases/MAGENTA/MAGENTA_EXE/DownloadScript.sh /databases/MAGENTA/MAGENTA_EXE/VerificationScript.sh

nohup sh /databases/MAGENTA/MAGENTA_EXE/Search_and_ClassifScript.sh  > /databases/MAGENTA/MAGENTA_EXE/Search_and_Classif_nohup 2>&1 &

nohup sh /databases/MAGENTA/MAGENTA_EXE/DownloadScript.sh  > /databases/MAGENTA/MAGENTA_EXE/Download_nohup 2>&1 &

nohup sh /databases/MAGENTA/MAGENTA_EXE/VerificationScript.sh  > /databases/MAGENTA/MAGENTA_EXE/Verification_nohup 2>&1 &





