#!/usr/bin/env bash

# Script to download RNA-seq test data from Griffith Lab
# Source: http://genomedata.org/rnaseq-tutorial/
# These are chr22-subset FASTQ files from HCC1395 (tumor/normal cell lines)

set -e  # Exit on error
set -u  # Exit on undefined variable

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Downloading Griffith Lab RNA-seq test data${NC}"
echo ""

# Create data directory
mkdir -p ./data
cd ./data

# Download the practice dataset
echo -e "${GREEN}Downloading HCC1395 practice dataset (chr22 subset)...${NC}"
echo "This includes tumor and normal samples from breast cancer cell line"
echo ""

wget --show-progress http://genomedata.org/rnaseq-tutorial/practical.tar

echo ""
echo -e "${GREEN}Extracting files...${NC}"
tar -xvf practical.tar

rm -f practical.tar

echo ""
echo -e "${GREEN}Download complete!${NC}"
echo ""
echo "Files downloaded to ./data/:"
ls -lh *.fastq.gz

echo ""
echo -e "${BLUE}Dataset information:${NC}"
echo "  Source: Griffith Lab RNA-seq Tutorial"
echo "  Sample: HCC1395 breast cancer cell line"
echo "  Normal: HCC1395 normal (matched lymphoblastoid line)"
echo "  Replicates: 3 tumor + 3 normal (paired-end)"
echo "  Data: Chromosome 22 subset (small for testing)"
echo "  Format: Paired-end 151bp Illumina HiSeq reads"
echo "  Reference: http://genomedata.org/rnaseq-tutorial/"
echo ""
echo -e "${GREEN}Samplesheet.csv has been pre-configured for these files${NC}"
echo "Ready to run: ./run_rnaseq.sh"
