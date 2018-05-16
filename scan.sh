#!/bin/bash
# Google Index & Alexa Rank Checker
# coded by Monkey B Luffy
# Greezt my little family BC0DE.NET
# 
#
#
# THIS TOOLS USE lynx
# install : sudo apt-get lynx (Ubuntu)

GooIndex(){
	web=$1
	# DEFAULT FOR INDONESIAN LANGUAGE
	# IF YOU USE DIFFERENT LANGUAGE CHANGE GOOGLE DOMAIN AND VALUE "Sekitar" AND "hasil" TO YOUR LANGUAGE
	GetIndex=$(lynx "https://www.google.co.id/search?q=site:${web}&start=0" -dump | grep -Po "(?<=Sekitar )[^ hasil]*")
	for hasil in $GetIndex; do
		printf "[!] Google Index : About $hasil Result\n"
	done
}
AlexaRank(){
	website=$1
	Alexas=$(curl -s "http://data.alexa.com/data?cli=10&dat=snbamz&url=${website}" -L)
	if [[ $Alexas =~ "<ALEXA" ]]; then
		GlobalRank=$(curl -s "http://data.alexa.com/data?cli=10&dat=snbamz&url=${website}" -L | grep -Po "(?<=TEXT=\")[^\"]*" | tail -1)
		COUNTRY=$(curl -s "http://data.alexa.com/data?cli=10&dat=snbamz&url=${website}" -L | grep -Po "(?<=NAME=\")[^\"]*" | tail -1)
		CountryRank=$(curl -s "http://data.alexa.com/data?cli=10&dat=snbamz&url=${website}" -L | grep -Po "(?<=RANK=\")[^\"]*" | tail -1)
		printf "[!] Alexa : \n"
		printf "    Country : $COUNTRY\n"
		printf "    Global Rank : $GlobalRank\n"
		printf "    Country Rank : $CountryRank\n\n"
	fi
	# for Glob in $GlobalRank; do
	# 	printf "[!] Alexa : \n"
	# 	printf "    Country : $COUNTRY\n"
	# 	printf "    Global Rank : $Glob\n"
	# 	printf "    Country Rank : $CountryRank\n\n"
	# done
}

for link in $(cat $1); do
	printf "\nWebsite : $link\n"
	if GooIndex $link; then AlexaRank $link; fi
done
