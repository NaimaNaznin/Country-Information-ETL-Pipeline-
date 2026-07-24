# Country Information ETL Pipeline

## Project Overview
This project is a Bash ETL pipeline that retrieves country information from a REST API based on user input. The script extracts the raw JSON data, processes the required fields using jq, validates the extracted data, and saves the final output to a TSV report. It also includes error handling and logging to make the pipeline more reliable.

## Features
- Retrieves country information from a REST API.
- Accepts a country name as user input.
- Processes JSON data using `jq`.
- Validates user input and API responses.
- Handles errors and logs pipeline activities.
- Exports the processed data to a TSV report.

## ETL Workflow 
1. User enters a country name.
2. The script retrieves data from the API.
3. The JSON response is processed with `jq`.
4. The extracted data is validated.
5. The processed data is written to a TSV report.
6. The pipeline logs the execution.

 ## Technologies Used
- Linux
- Bash
- REST API
- curl
- jq
- JSON
- Git

## How to Run
1. Clone the repository.
2. Open a terminal and navigate to the project directory:
   ```Bash
   cd country-info-ETL
   ```
3. Make the script executable:
   ```Bash
   chmod +x countryETL.sh
   ```
4. Run the script:
   ```Bash
   ./countryETL.sh
   ```
5. Enter a country name when prompted. The processed data will be saved in:
   `data/country_report.tsv`
