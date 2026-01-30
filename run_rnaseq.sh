#!/usr/bin/env bash

# Standard nf-core/rnaseq run script using iGenomes (RECOMMENDED)
# This script uses AWS iGenomes for automatic genome download
#
# Usage: ./run_rnaseq.sh
# Make sure to:
# 1. Edit samplesheet.csv with your FASTQ file paths
# 2. Update SLURM account in osc.config if needed
# 3. Change --genome if not using human GRCh38

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

    # Reference genome (iGenomes)
    "--genome" "GRCh38"              # AWS iGenomes reference (auto-download)
                                     # Options: GRCh38, GRCh37, GRCm39, GRCm38, etc.

    # Pipeline options
    "--aligner" "star_salmon"        # Alignment and quantification method
                                     # Options: star_salmon, star_rsem, hisat2
    "--save_reference"               # Save downloaded genome and indices for reuse

    # Optional parameters (uncomment to use)
    # "--skip_fastqc"                # Skip FastQC step
    # "--skip_trimming"              # Skip adapter trimming
    # "--min_trimmed_reads" "10000"  # Filter samples with < 10k reads
    # "--save_trimmed"               # Save trimmed FASTQ files
    # "--save_unaligned"             # Save unaligned reads
)

# Run the pipeline
nextflow run nf-core/rnaseq "${PARAMS[@]}"
