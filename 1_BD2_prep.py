###Prepares multi-fasta file containing cox1 sequences for submisison to BOLDigger2
###Removes sequence headers if no sequence present and converts invald characters to 'Ns'


import os
import sys

def clean_fasta(input_fasta, output_fasta):
    with open(input_fasta, 'r') as infile, open(output_fasta, 'w') as outfile:
        write_header = False 
        for line in infile:
            if line.startswith('>'):
                header = line.strip().split('.')[0]  #clean seq header by removing anything after and including '.'
                sequence = next(infile, '').strip()
                if sequence:  #0nly write header if there's a sequence below it
                    outfile.write(header + '\n')
                    sequence = sequence.replace('-', 'N').replace('~', 'N') #replace invalid characters with Ns
                    outfile.write(sequence + '\n')
            else:
                continue


if __name__ == "__main__":
    if len(sys.argv) != 3:

        print("Usage: python 1_BD2_prep.py /path/to/input.fasta output.fasta")
        sys.exit(1)

    input_fasta = sys.argv[1]
    output_fasta = sys.argv[2]


#output.fasta to same dir as the input.fasta
    if not os.path.isabs(output_fasta):
        output_fasta = os.path.join(os.path.dirname(input_fasta), output_fasta)

    clean_fasta(input_fasta, output_fasta)
    print(f"Cleaned FASTA file saved as {output_fasta}")
