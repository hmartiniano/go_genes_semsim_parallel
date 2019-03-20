# go_genes_semsim_parallel
R script to calculate a gene semantic similarity matrix for approved HGNC genes using th GOSemSim package 

# Usage
Create a conda environment

```bash
conda create -n go -f environment.yml

Download hgcn file

```bash
wget ftp://ftp.ebi.ac.uk/pub/databases/genenames/new/tsv/hgnc_complete_set.txt

Run script

```bash
bash ./run.sh
