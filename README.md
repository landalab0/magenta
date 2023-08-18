# MAGENTA

MAGENTA es una base de datos automática, que tiene la capacidad de:

  A) Buscar, clasificar y descargar los datos “crudos” (archivos .fastq) de proyectos enfocados al estudio de ecosistemas
  de manglar almacenados dentro de la base de datos especializada: European Nucleotide Archive (ENA).
  B)
  C)
	

  A) MAGENTA como un software que busca, clasifica y descarga datos:

  Script #0: MAGENTA.sh //Sin funcionar, no se está utilizando por el momento
    SuperScript cuyo principal objetivo es adecuar el ambiente de Magenta como base de datos (crea carpetas, da permiso de ejecución, etc)
    y correr posteriores scripts.

    Algunos puntos a tomar en cuenta ANTES de correr MAGENTA.sh:
    En terminal:
      - Antes de ejecutarlo, 
          - Dirigirse a la carpeta en donde se desea crear la base de datos MAGENTA: cd /databases/MAGENTA
          - Obtener permisos de root : sudo su ....
          - Descargar los scripts de git: git clone https://github.com/landalab0/magenta.git (se crea carpeta "magenta" con los scripts adentro auto)
          - Dar permisos de ejecución a MAGENTA.sh : chmod a+x MAGENTA.sh
      - Al ejecutarlo,
          - Ejecutarlo con : nohup sh MAGENTA.sh > MAGENTA_DB_nohup 2>&1 &


  Script #1: Search_and_ClassifScript.sh
    Script que ENCUENTRA los proyectos, los ORGANIZA con base en el tipo de análisis (WGS, AMPLICON, RNA_S), y OBTIENE su metadata.
    
  
  Script #2: DownloadScript.sh
    Script que DESCARGA los datos crudos (los datos "sin procesar"; es decir, los archivos .fastq) de cada proyecto.

    
  Script #3: VerificationScript.sh
    Script que, despúes de la descarga, VERIFICA en la base de datos los DATOS REALES descargados y, REDESCARGA los datos faltantes
    si fuera el caso.
  
