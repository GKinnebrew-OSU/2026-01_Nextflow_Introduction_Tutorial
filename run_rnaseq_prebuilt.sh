#!/usr/bin/env bash

# nf-core/rnaseq run script using pre-built indices
# Use this when you already have reference genome indices from previous runs
#
# Usage: ./run_rnaseq_prebuilt.sh
# Prerequisites:
# 1. Run a pipeline with --save_reference first to create indices
# 2. Update paths below to point to saved reference directory

# Reference directory with pre-built indices
REF_DIR="/fs/ess/PCON0005/references/GRCh38_from_iGenomes"

# Verify reference files exist
if [ ! -f "${REF_DIR}/genome.fa" ]; then
    echo "ERROR: Reference directory not found or incomplete: $REF_DIR"
    echo "Run a pipeline with --save_reference first to create indices"
    exit 1
fi

echo "Using pre-built indices from: $REF_DIR"
echo ""

# Array of pipeline parameters
PARAMS=(
    # Pipeline version and execution
    "-r" "3.22.2"                         # Pin specific pipeline version
    "-resume"                             # Resume from last successful step

    # Configuration files
    "-c" "osc.config"                     # OSC-specific configuration
    "-profile" "singularity"              # Use Singularity containers
    "-w" "./work"                         # Nextflow working directory

    # Input/Output
    "--input" "./samplesheet.csv"         # Sample metadata and FASTQ paths
    "--outdir" "./results"                # Output directory for results

    # Reference genome (pre-built indices)
    "--igenomes_ignore"                   # Don't use iGenomes
    "--fasta" "${REF_DIR}/genome.fa"      # Reference genome FASTA
    "--gtf" "${REF_DIR}/genome.gtf"       # Gene annotation GTF
    "--star_index" "${REF_DIR}/star"      # Pre-built STAR index
    "--salmon_index" "${REF_DIR}/salmon"  # Pre-built Salmon index

    # Pipeline options
    "--aligner" "star_salmon"             # Use STAR + Salmon
    # "--save_reference" "false"          # Don't re-save (already have indices)
)

# Run the pipeline
nextflow run nf-core/rnaseq "${PARAMS[@]}"
