###Prepares multi-fasta file containing cox1 sequences for submisison to BOLDigger2


import os
import sys



def clean_fasta(input_fasta, output_fasta, min_length=80):
    def clean_sequence(seq):
#Remove leading and trailing invalid characters, and replace remaining with Ns
        seq = seq.lstrip('-~')
        seq = seq.rstrip('-~')
        seq = seq.replace('-', 'N').replace('~', 'N')
        return seq


    
    with open(input_fasta, 'r') as infile, open(output_fasta, 'w') as outfile:
        write_header = False
        for line in infile:
            if line.startswith('>'):
#Clean seq header of any fle extension by removing anything after and including '.'
                header = line.strip().split('.')[0]
                sequence = next(infile, '').strip()
                if sequence:  # Only write header if there's a sequence below it
                    cleaned_sequence = clean_sequence(sequence)
                    if len(cleaned_sequence) >= min_length:
                        outfile.write(header + '\n')
                        outfile.write(cleaned_sequence + '\n')
            else:
                continue



if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python 1_BD2_prep.py /path/to/input.fasta output.fasta")
        sys.exit(1)

    input_fasta = sys.argv[1]
    output_fasta = sys.argv[2]

    

#Output cleaned .fasta to same dir as input .fasta
    if not os.path.isabs(output_fasta):
        output_fasta = os.path.join(os.path.dirname(input_fasta), output_fasta)

    clean_fasta(input_fasta, output_fasta)
