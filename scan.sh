#!/bin/bash

echo "BASH SCRIPT COMMEND/ BY Ammar Yasser"

read -p "Enter domain name: " DOMAIN

OUTPUT_DIR="/home/ammar/Desktop/test"
mkdir -p $OUTPUT_DIR

subfinder -d $DOMAIN | sort -u >> $OUTPUT_DIR/subdomains.txt

./sublist3r.py -d /home/ammar/sublist3r/$DOMAIN -o $OUTPUT_DIR/subdomains.txt

assetfinder -subs-only $DOMAIN >> $OUTPUT_DIR/subdomains.txt

#chaos -d domain.com

#findomain -t moj.io

altdns -i $OUTPUT_DIR/subdomains.txt -o $OUTPUT_DIR/permutationoutput.txt -w $Tools/altdns/words.txt -r -s resolved_output.txt

cat $OUTPUT_DIR/subdomains.txt | dnsgen - | massdns -r $OUTPUT_DIR/resolvers.txt -t A -o J --flush 2>/dev/null

#cat domains.resolved | httprobe -c 50 -p 8080,8081,8089 | tee http.servers

httpx -list $OUTPUT_DIR/subdomains.txt -o $OUTPUT_DIR/live.txt

cat $OUTPUT_DIR/live.txt | aquatone -scan-timeout 10000000 -screenshot-timeout 1000000 -out $OUTPUT_DIR

subjs -i $OUTPUT_DIR/live.txt | sort -u > $OUTPUT_DIR/js.txt

httpx -list $OUTPUT_DIR/js.txt -o $OUTPUT_DIR/livejs.txt

echo "$DOMAIN" | gau --threads 5 >> $OUTPUT_DIR/Enpoints.txt

cat $OUTPUT_DIR/live.txt | katana -jc >> $OUTPUT_DIR/Enpoints.txt

cat $OUTPUT_DIR/Enpoints.txt | uro >> $OUTPUT_DIR/Endpoints_F.txt

cat $OUTPUT_DIR/Endpoints_F.txt | gf xss >> $OUTPUT_DIR/XSS.txt

cat $OUTPUT_DIR/XSS.txt | Gxss -o $OUTPUT_DIR/XSS_Ref.txt

dalfox file $OUTPUT_DIR/XSS_Ref.txt -o $OUTPUT_DIR/Vulnerable_XSS.txt

#python asnlookup.py -o <Organization>`

amass enum -d $Domain >> /home/ammar/Desktop/test/amass.txt

gospider -S $OUTPUT_DIR/live.txt -o $OUTPUT_DIR/go_spider -c 10 -d 1 -t 20

echo "[*] Results saved to $OUTPUT_DIR"

#python3 dirsearch.py -e php,html,js -u https://target

#arjun -u https://tst2.dev.targets.com/cgi-bin/fr.cfg/php/custom/id-pass.php -m GET -w Parameters_Fuzz.txt ex: for a manual test
