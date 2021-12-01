#!/bin/sh
#############################################################
# Developed by John Carter (john.carter@softwareag.com) 
# Dec 2021
#
# Updates custom_config.conf to update min, max memory settings
#
#############################################################

replace_symbol_in_file() {
	
	file=$1
	symbol1=$2
	text1=$3
	symbol2=$4
	text2=$5
	
	p="{${file}}"
	
	if [ "x{text2" == "x" ]
	then
		sed "/${symbol1}/s/.*/${symbol1}\=${text1}/" ${file} > ${file}.bk
	else
		sed -e "/${symbol1}/s/.*/${symbol1}\=${text1}/" -e "/${symbol2}/s/.*/${symbol2}\=${text2}/" ${file} > ${file}.bk
	fi
	
	rm ${file}
	mv ${file}.bk ${file}
}

if [ "x${2}" != 'x' ] 
then
	replace_symbol_in_file $1/configuration/custom_wrapper.conf wrapper.java.initmemory $2 wrapper.java.maxmemory $3
fi