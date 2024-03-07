#!/bin/bash

echo "BASH SCRIPT COMMEND/ BY Ammar Yasser"

read -p "Enter domain name: " DOMAIN

OUTPUT_DIR="/home/kali/Desktop/test"
mkdir -p $OUTPUT_DIR

subfinder -d $DOMAIN | sort -u > $OUTPUT_DIR/subdomains.txt

python sublist3r.py -d $DOMAIN >> $OUTPUT_DIR/subdomains.txt

assetfinder -subs-only $DOMAIN >> $OUTPUT_DIR/subdomains.txt

httpx -list $OUTPUT_DIR/subdomains.txt -o $OUTPUT_DIR/live.txt

cat $OUTPUT_DIR/live.txt | aquatone -scan-timeout 1000000 -screenshot-timeout 1000000 -out $OUTPUT_DIR

subjs -i $OUTPUT_DIR/live.txt | sort -u > $OUTPUT_DIR/js.txt

httpx -list $OUTPUT_DIR/js.txt -o $OUTPUT_DIR/livejs.txt

echo "[*] PASSIVE END $OUTPUT_DIR"

echo "[*] ACTIVE START $OUTPUT_DIR"

echo "$DOMAIN" | gau --threads 5 >> $OUTPUT_DIR/Enpoints.txt

cat $OUTPUT_DIR/live.txt | katana -jc >> $OUTPUT_DIR/Enpoints.txt

cat $OUTPUT_DIR/Enpoints.txt | uro >> $OUTPUT_DIR/Endpoints_F.txt

cat $OUTPUT_DIR/Endpoints_F.txt | gf xss >> $OUTPUT_DIR/XSS.txt

cat $OUTPUT_DIR/XSS.txt | Gxss -p khXSS -o $OUTPUT_DIR/XSS_Ref.txt

dalfox file $OUTPUT_DIR/XSS_Ref.txt -o $OUTPUT_DIR/Vulnerable_XSS.txt

echo "[*] Results saved to $OUTPUT_DIR"


#arjun -u https://tst2.dev.targets.com/cgi-bin/fr.cfg/php/custom/id-pass.php -m GET -w Parameters_Fuzz.txt ex: for a manual test
