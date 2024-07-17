# BOLDigger2_batch
Bash script for batch submission of cox1 barcodes to [BOLDigger2](https://github.com/DominikBuchner/BOLDigger2) via slurm HPC.




**Usage: sbatch boldigger2.sh [path/to/cox1.fasta] [username] [password] [path/to/output_dir]**
- **path/to/cox1.fasta** = path to directory with multi-fasta file containing cox1 sequences to query against BOLD DB (.fasta must have 'cox1' in filename).
- **username** = BOLD username
- **password** = BOLD password
- **path/to/output_dir** = path to directory to output BOLDigger2 results. Will create output_dir.



## BOLDigger2 multi-fasta prep script (1_BD2_prep.py)
Prepares multi-fasta file containing cox1 sequences for submisison to BOLDigger2 by cleaning sequence headers, removing  headers if no sequence present, and converting invald characters to 'Ns'

**Usage:**
**python 1_BD2_prep.py [/path/to/input.fasta] [output.fasta]**
- **/path/to/input.fasta** = path to directory with multi-fasta file containing cox1 sequences.
- **output.fasta** = user-specified name of output fasta file. Will be output to same directory as input fasta file.

