#!/bin/bash 
echo "Country pipeline started" 
echo "$(date) - Pipeline started" >> logs/pipeline.log

# Dependency check

if command -v curl
then 
	echo "curl exists"
else
	echo "ERROR: curl is not installed"
	echo "$(date) - ERROR: curl is missing" >>logs/pipeline.log
	exit 1
fi

if command -v jq
then
        echo "jq exists"
else
	echo "ERROR: jq is not installed"
	echo "$(date) - ERROR: jq is missing" >> logs/pipeline.log
	exit 1
fi

# User input and validation

echo "Enter the country name: "
read country 

if [ -z "$country" ]
then
	echo "ERROR: Country name cannot be empty"
        echo "$(date) - ERROR: COuntry name cannot be empty" >> logs/pipeline.log
        exit 1
fi

echo "$(date) - Country entered:$country" >> logs/pipeline.log

echo "Fetching country information"

# Extract & validate API response 

if curl -s https://countries.dev/name/$country > data/raw_country.json
then
    echo "$(date) - Country information fetched successfully" >> logs/pipeline.log
else
    echo "Failed to fetch country information"	
    echo "$(date) - ERROR: Failed to fetch country information" >> logs/pipeline.log
    exit 1
fi


if grep -i "Country not found" data/raw_country.json >/dev/null
then
	echo "ERROR: Invalid country"
	echo "$(date) - ERROR: Invalid country" >> logs/pipeline.log
	exit 1
fi

# Transform & validate data

name=$(jq -r '.[0].name' data/raw_country.json)
capital=$(jq -r '.[0].capital' data/raw_country.json)
region=$(jq -r '.[0].region' data/raw_country.json)
population=$(jq -r '.[0].population' data/raw_country.json)
language=$(jq -r '.[0].languages[0].name' data/raw_country.json)
flag=$(jq -r '.[0].flag' data/raw_country.json)
currency=$(jq -r '.[0].currencies[0].name' data/raw_country.json)
area=$(jq -r '.[0].area' data/raw_country.json)
timezone=$(jq -r '.[0].timezones[0]' data/raw_country.json)                                                           

if [ -z "$name" ]
then
	echo "Failed to extract country name"
	echo "$(date) - ERROR: Failed to extract country name" >> logs/pipeline.log
	exit 1

fi

# Load & log completion

if [ ! -f data/country_report.tsv ]
then
	echo -e "Name\tCapital\tRegion\tPopulation\tLanguage\tFlag\tCurrency\tArea\tTimezone" > data/country_report.tsv
fi	

echo -e "$name\t$capital\t$region\t$population\t$language\t$flag\t$currency\t$area\t$timezone" >> data/country_report.tsv

echo "Pipeline completed succesfully"
echo "$(date) - Pipeline completed succesfully" >> logs/pipeline.log

~                                                 
~

