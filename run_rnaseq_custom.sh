#!/usr/bin/env bash

# nf-core/rnaseq run script using custom reference genomes
# Use this when you need specific/updated genome files from Ensembl/GENCODE
#
# Usage: ./run_rnaseq_custom.sh
# Prerequisites:
# 1. Download custom genome files (see download_references.sh)
# 2. Update paths to FASTA and GTF files below

# Use readlink -m to convert to absolute paths
# This prevents GUNZIP null pointer errors
FASTA=$(readlink -m /fs/ess/PCON0005/references/GRCh38_Ensembl113/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz)
GTF=$(readlink -m /fs/ess/PCON0005/references/GRCh38_Ensembl113/Homo_sapiens.GRCh38.113.gtf.gz)

# Verify files exist
if [ ! -f "$FASTA" ]; then
    echo "ERROR: FASTA file not found: $FASTA"
    exit 1
fi

if [ ! -f "$GTF" ]; then
    echo "ERROR: GTF file not found: $GTF"
    exit 1
fi

echo "Using FASTA: $FASTA"
echo "Using GTF: $GTF"
echo ""

# Array of pipeline parameters
PARAMS=(
    # Pipeline version and execution
    "-r" "3.22.2"                    # Pin specific pipeline version
    "-resume"                        # Resume from last successful step if restarting

    # Configuration files
    "-c" "osc.config"                # OSC-specific configuration (SLURM, Singularity)
    "-profile" "singularity"         # Use Singularity containers
    "-w" "./work"                    # Nextflow working directory

    # Input/Output
    "--input" "./samplesheet.csv"    # Sample metadata and FASTQ paths
    "--outdir" "./results"           # Output directory for results

    # Reference genome (custom files)
    "--igenomes_ignore"              # Don't use iGenomes
    "--fasta" "$FASTA"               # Custom reference genome FASTA
    "--gtf" "$GTF"                   # Custom gene annotation GTF

    # Pipeline options
    "--aligner" "star_salmon"        # Alignment and quantification method
    "--save_reference"               # Save built indices for future use
)

# Run the pipeline
nextflow run nf-core/rnaseq "${PARAMS[@]}"
