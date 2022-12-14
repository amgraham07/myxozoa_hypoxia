#!/bin/bash

for fn in ./*.PROT.fasta
do

# get the path to the file
dir=`dirname $fn`;

# get just the file (without the path)
base=`basename $fn`;

# the read filename, without the *.PROT.fasta suffix
rf=${base%.*.PROT.fasta};

# Do whatever we want with it
echo ">>>>>>>>>>Index Protein Files<<<<<<<<<<<<<"
./esl-sfetch --index ${dir}/${rf}
echo ">>>>>>>>>>HMMR Search for PAS domain<<<<<<<<<<<<<"
hmmsearch -E 0.01 --tblout ${dir}/${rf}_tblout PAS.hmm ${dir}/${rf}
echo ">>>>>>>>>>Grep out significant hit names<<<<<<<<<<<<<"
grep --invert-match "^#" ${dir}/${rf}_tblout | awk '{print $1}' > ${dir}/${rf}_PAS_hits
echo ">>>>>>>>>>Grab out the sequences<<<<<<<<<<<<<"
./esl-sfetch -f ${dir}/${rf} ${dir}/${rf}_PAS_hits > ${dir}/${rf}_PAS_sequences.fasta

done