# BOLDigger2_batch
Submission of multi-fasta file containing cox1 sequences to [BOLDigger2](https://github.com/DominikBuchner/BOLDigger2) via slurm HPC.




**Usage: sbatch boldigger2.sh [path/to/cox1.fasta] [username] [password] [path/to/output_dir]**
- **path/to/cox1.fasta** = path to directory with multi-fasta file containing cox1 sequences to query against BOLD DB (.fasta must have 'cox1' in filename).
- **username** = BOLD username
- **password** = BOLD password
- **path/to/output_dir** = path to directory to output BOLDigger2 results. Will create output_dir if it does not already exist.



## BOLDigger2 multi-fasta prep script (1_BD2_prep.py)
Integrated into boldigger.sh (must be in same directory as boldigger.sh). Prepares multi-fasta file containing cox1 sequences by cleaning sequence headers, removing headers if no sequence is present, removing leading and trailing invalid characters (e.g. '-' and '~'), converting 'internal' invalid characters to 'Ns', and removing sequences <80bp. Script will append 'cleaned_' to start of input cox1.fasta file, which will be used for submission to BOLDigger2.

