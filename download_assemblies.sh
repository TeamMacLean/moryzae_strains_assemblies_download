#!/bin/bash

awk -F "," '{print $(NF-1)" "$3}' data/metadata.csv | tail -n+2 | sed 's/"//g' > strains_ftp.txt;
while read ftplink; do 
	strain=$(echo $ftplink | awk '{print $2}'); 
	ftp=$(echo $ftplink | awk '{print $1}'); 
	base=$(basename $ftp);  
	wget  ${ftp}/${base}_genomic.fna.gz && if [[ "$strain" != "" ]];  then echo "Renaming "; mv ${base}_genomic.fna.gz ${strain}_${base}_genomic.fna.gz; else echo "No Strain name, no need to rename"; fi; 
done < strains_ftp.txt

rm strains_ftp.txt

