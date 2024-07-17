#!/bin/bash
#SBATCH --job-name=BD2
#SBATCH --partition=day
#SBATCH --output=BD2_%A_%a.out
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=4
#SBATCH --error=BD2_%A_%a.err


#requires BOLDigger2 to be installed in conda env
source ~/miniconda3/etc/profile.d/conda.sh
conda init bash
conda activate boldigger




####sbatch boldigger2.sh /path/to/cox1.fasta/dir danip3 bge_nhm /path/to/output/dir

#check if correct number of arguments are provided by user (see above) ($# = contains no. argumetns passed to script)
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 path/to/cox1.fasta username password path/to/output_dir (will create output_dir)"
    exit 1
fi


#assign arguments to variables
PATH_TO_FASTA_DIR=$1
USERNAME=$2
PASSWORD=$3
OUTPUT_DIR=$4


#debug dirs
echo "Path to FASTA directory: $PATH_TO_FASTA_DIR"
echo "Output directory: $OUTPUT_DIR"


#find file with 'cox1' in file name
PATH_TO_FASTA=$(find "$PATH_TO_FASTA_DIR" -type f -name "*cox1*")


#check if cox1.fasta file was found
if [ -z "$PATH_TO_FASTA" ]; then
    echo "Error: No file with 'cox1' in its name found in the specified directory."
    exit 1
else
    echo "Found FASTA file: $PATH_TO_FASTA"
fi


#run BOLDigger2
boldigger2 identify $PATH_TO_FASTA -username $USERNAME -password $PASSWORD


#check if the output directory given exists, if not then mkdir
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi


#move BOLDigger2 output files to user specified directory
find "$PATH_TO_FASTA_DIR" -type f \( -name "*download_links*" -o -name "*identification*" -o -name "*top_100*" \) -exec mv {} "$OUTPUT_DIR/" \;


echo "Succesfully moved BOLDigger2 outputs to $OUTPUT_DIR"
