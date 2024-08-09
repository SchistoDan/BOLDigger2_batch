#!/bin/bash
#SBATCH --job-name=BD2
#SBATCH --partition=day
#SBATCH --output=BD2_%A.out
#SBATCH --mem-per-cpu=20G
#SBATCH --cpus-per-task=8
#SBATCH --error=BD2_%A.err



#requires BOLDigger2 to be (pip) installed in conda env
source ~/miniconda3/etc/profile.d/conda.sh
conda init bash
conda activate boldigger





####sbatch boldigger2.sh /path/to/cox1.fasta/dir danip3 bge_nhm /path/to/output/dir

#check if correct number of arguments are provided by user (see above) ($# = contains no. argumetns passed to script)
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 path/to/cox1.fasta username password path/to/output_dir (will create output_dir)"
    exit 1
fi



#Assign arguments to variables
PATH_TO_FASTA_DIR=$1
USERNAME=$2
PASSWORD=$3
OUTPUT_DIR=$4

echo "Output directory: $OUTPUT_DIR"
echo "FASTA file directory: $PATH_TO_FASTA_DIR"



#Find multi fasta file with 'cox1' in file name & check if found
PATH_TO_FASTA=$(find "$PATH_TO_FASTA_DIR" -type f -name "*cox1*")

if [ -z "$PATH_TO_FASTA" ]; then
    echo "Error: No file with 'cox1' in its name found in the specified directory."
    exit 1
else
    echo "Found FASTA file: $PATH_TO_FASTA"
fi



#Set 'cleaned' *cox1*.fasta path (appends 'cleaned_' to start of filename)
CLEANED_FASTA=$(dirname "$PATH_TO_FASTA")/cleaned_$(basename "$PATH_TO_FASTA")



#Run Python script to clean cox1.fasta & check if it was created 
python 1_BD2_prep.py "$PATH_TO_FASTA" "$CLEANED_FASTA"

if [ ! -f "$CLEANED_FASTA" ]; then
    echo "Error: Cleaned FASTA file was not created."
    exit 1
else
    echo "Cleaned FASTA file created: $CLEANED_FASTA"
fi



#Run BOLDigger2
boldigger2 identify "$CLEANED_FASTA" -username "$USERNAME" -password "$PASSWORD"



#Check if the output directory given exists, if not then mkdir
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi



#Extract dir path from the FASTA file path & validate
COX1_DIR=$(dirname "$PATH_TO_FASTA")

echo "Listing files in $COX1_DIR:"
ls -l "$COX1_DIR"



#Move BOLDigger2 output files to user specified directory & validate move
find "$COX1_DIR" -type f \( -name "*download_links*" -o -name "*identification*" -o -name "*top_100*" \) -exec mv {} "$OUTPUT_DIR/" \;

echo "Files in $OUTPUT_DIR after move:"
ls -l "$OUTPUT_DIR"

echo "Succesfully moved BOLDigger2 outputs to $OUTPUT_DIR"
