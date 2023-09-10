#!/usr/bin/env bash
# script for downloading an XML file and extracting it's body text

# download webpage in XML format from provided URL
# 1. extract text bounded by the body tags
# 2. remove remaining XML tags
# 3. remove body tags
# 4. remove ASCII control codes
# 5. remove DOS newlines
# 6. remove non UTF-8 characters
curl $1 \
	| sed -n '/Start Body/,/End Body/p' \
	| sed 's/<.*>//gi' \
	| sed 's/<!-- End Body -->//' \
	| sed 's/<!-- Start Body -->//' \
	| sed -E 's/\x1b\[[0-9]*;?[0-9]+m//g' \
	| sed -e 's/\r//g' \
	| tr -d '\200-\377' > output.md
