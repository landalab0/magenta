# MAGENTA 

(Recomendación: leerse en modo "CODE" para una mayor comprensión)

MAGENTA es una base de datos automática, que tiene la capacidad de:

  A) Buscar, clasificar y descargar los datos “crudos” (archivos .fastq) de proyectos enfocados al estudio de ecosistemas
  de manglar almacenados dentro de la base de datos especializada: European Nucleotide Archive (ENA).
  B)
  C)
	

  A) MAGENTA como un software que busca, clasifica y descarga datos:

  Script #0: MAGENTA.sh 
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
  




## References  
[ ][Antibiotic resistance and metabolic profiles as functional biomarkers that accurately predict the geographic origin of city metagenomics samples
](https://biologydirect.biomedcentral.com/articles/10.1186/s13062-019-0246-9)  
[ ][Forensic Applications of Microbiomics: A Review](https://www.frontiersin.org/articles/10.3389/fmicb.2020.608101/full)  
[ ][Identification of city specific important bacterial signature for the MetaSUB CAMDA challenge microbiome data](https://link.springer.com/article/10.1186/s13062-019-0243-z)    
[ ][Editorial: Critical assessment of massive data analysis (CAMDA) annual conference 2021](https://www.frontiersin.org/articles/10.3389/fgene.2023.1154398/full)     
[ ][Unraveling city-specific signature and identifying sample origin locations for the data from CAMDA MetaSUB challenge](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7780616/)      
[ ][Unraveling City-Specific Microbial Signatures and Identifying Sample Origins for the Data From CAMDA 2020 Metagenomic Geolocation Challenge](https://pubmed.ncbi.nlm.nih.gov/34421984/)   
[ ][Metagenomic Geolocation Using Read Signatures](https://pubmed.ncbi.nlm.nih.gov/35295949/)    
[ ][Identification of city specific important bacterial signature for the MetaSUB CAMDA challenge microbiome data](https://pubmed.ncbi.nlm.nih.gov/31340852/)  
[ ][Unraveling bacterial fingerprints of city subways from microbiome 16S gene profiles](https://pubmed.ncbi.nlm.nih.gov/29789016/)  
[ ][Fingerprinting cities: differentiating subway microbiome functionality](https://pubmed.ncbi.nlm.nih.gov/31666099/)  
[ ][Origin Sample Prediction and Spatial Modeling of Antimicrobial Resistance in Metagenomic Sequencing Data](https://pubmed.ncbi.nlm.nih.gov/33763122/)
[ ][Application of machine learning techniques for creating urban microbial fingerprints](https://pubmed.ncbi.nlm.nih.gov/31420049/)   
[ ][Metagenomic Geolocation Prediction Using an Adaptive Ensemble Classifier](https://pubmed.ncbi.nlm.nih.gov/33959149/)    
[ ][Massive metagenomic data analysis using abundance-based machine learning](https://pubmed.ncbi.nlm.nih.gov/31370905/)  
[ ][Environmental metagenome classification for constructing a microbiome fingerprint](https://pubmed.ncbi.nlm.nih.gov/31722729/)   
[ ][A machine learning framework to determine geolocations from metagenomic profiling](https://pubmed.ncbi.nlm.nih.gov/33225966/)  
[ ][Profiling microbial strains in urban environments using metagenomic sequencing data](https://pubmed.ncbi.nlm.nih.gov/29743119/)   
[ ][Systematic evaluation of supervised machine learning for sample origin prediction using metagenomic sequencing data](https://pubmed.ncbi.nlm.nih.gov/33302990/)  
[ ][MetaBinG2: a fast and accurate metagenomic sequence classification system for samples with many unknown organisms](https://pubmed.ncbi.nlm.nih.gov/30134953/)  
[ ][Assessment of urban microbiome assemblies with the help of targeted in silico gold standards](https://pubmed.ncbi.nlm.nih.gov/30621760/)  
[ ][Metagenomics Analyses: A Qualitative Assessment Tool for Applications in Forensic Sciences](https://link.springer.com/chapter/10.1007/978-981-15-6529-8_5)  
[ ][Forensic Applications of Microbiomics: A Review](https://www.frontiersin.org/articles/10.3389/fmicb.2020.608101/full)  
[ ][Application of Microbiome in Forensics](https://www.sciencedirect.com/science/article/pii/S1672022922000961)  
[ ][Environmental metagenomics in urban environments and development of forensic inference](https://www.kcl.ac.uk/research/environmental-metagenomics-in-urban-environments-and-development-of-forensic-inference)  
[ ][Origin Sample Prediction and Spatial Modeling of Antimicrobial Resistance in Metagenomic Sequencing Data](https://pubmed.ncbi.nlm.nih.gov/33763122/)  
