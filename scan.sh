#!/bin/bash
# Google Index & Alexa Rank Checker
# coded by Monkey B Luffy
# Greezt my little family BC0DE.NET
# 
#
#
# THIS TOOLS USE lynx
# install : sudo apt-get lynx (Ubuntu)
clear
# GooIndex(){
# 	web=$1
# 	# DEFAULT FOR INDONESIAN LANGUAGE
# 	# IF YOU USE DIFFERENT LANGUAGE, CHANGE GOOGLE DOMAIN AND VALUE "Sekitar" AND "hasil" TO YOUR LANGUAGE
# 	GetIndex=$(lynx "https://www.google.co.id/search?q=site:${web}&start=0" -dump -accept_all_cookies | grep -Po "(?<=Sekitar )[^ hasil]*")
# 	for hasil in $GetIndex; do
# 		printf "[!] Google Index : About $hasil Result\n"
# 	done
# }
GooIndex(){
	web=$1
	# DEFAULT FOR INDONESIAN LANGUAGE
	# IF YOU USE DIFFERENT LANGUAGE, CHANGE GOOGLE DOMAIN AND VALUE "Sekitar" AND "hasil" TO YOUR LANGUAGE
	GetIndex=$(lynx "https://www.google.co.id/search?q=site:${web}&start=0" -dump -accept_all_cookies)
	if [[ ! $GetIndex =~ "tidak cocok dengan dokumen" ]]; then
			GetValueGoo=$(echo $GetIndex | grep -Po "(?<=Sekitar )[^ hasil]*")
			printf "[!] Google Index : About $GetValueGoo Result\n"
			echo "[!] Google Index : About $GetValueGoo Result" >> Result.txt
	else
			printf "[!] Google Index : -\n"
			echo "[!] Google Index : -" >> Result.txt
	fi
}
AlexaRank(){
	website=$1
	Alexas=$(curl -s "http://data.alexa.com/data?cli=10&dat=snbamz&url=${website}" -L)
	GlobalRank=$(curl -s "http://data.alexa.com/data?cli=10&dat=snbamz&url=${website}" -L | grep -Po "(?<=TEXT=\")[^\"]*" | tail -1)
	COUNTRY=$(curl -s "http://data.alexa.com/data?cli=10&dat=snbamz&url=${website}" -L | grep -Po "(?<=NAME=\")[^\"]*" | tail -1)
	CountryRank=$(curl -s "http://data.alexa.com/data?cli=10&dat=snbamz&url=${website}" -L | grep -Po "(?<=RANK=\")[^\"]*" | tail -1)
	if [[ $Alexas =~ "<POPULARITY" ]]; then
		printf "[!] Alexa : \n"
		echo "[!] Alexa : " >> Result.txt
		printf "    Country : $COUNTRY\n"
		echo "    Country : $COUNTRY" >> Result.txt
		printf "    Global Rank : $GlobalRank\n"
		echo "    Global Rank : $GlobalRank" >> Result.txt
		printf "    Country Rank : $CountryRank\n"
		echo "    Country Rank : $CountryRank" >> Result.txt
		echo "================================" >> Result.txt
	else
	# for Glob in $GlobalRank; do
		printf "[!] Alexa : \n"
		echo "[!] Alexa : " >> Result.txt
		printf "    Country : -\n"
		echo "    Country : -" >> Result.txt
		printf "    Global Rank : -\n"
		echo "    Global Rank : -" >> Result.txt
		printf "    Country Rank : -\n"
		echo "    Country Rank : -" >> Result.txt
		echo "================================" >> Result.txt
	# done
	fi
}

for link in $(cat $1); do
	printf "\nWebsite : $link\n"
	echo "Website : $link" >> Result.txt
	if GooIndex $link; then AlexaRank $link; fi
done
printf "\n"
