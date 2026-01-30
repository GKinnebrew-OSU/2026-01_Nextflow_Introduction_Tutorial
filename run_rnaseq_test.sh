#!/usr/bin/env bash

# Quick test run using nf-core built-in test data
# Use this to verify your Nextflow/Singularity setup before running real data
#
# Usage: ./run_rnaseq_test.sh
#
# This will:
# - Download small test FASTQ files (~10-15 minutes)
# - Use yeast genome (R64-1-1, small and fast)
# - Run complete pipeline to verify everything works
# - No need to create samplesheet - uses built-in test data

echo "=== Running nf-core/rnaseq test profile ==="
echo "This will take approximately 10-15 minutes"
echo ""

# Array of pipeline parameters
PARAMS=(
    # Pipeline version
    "-r" "3.22.2"                    # Pin specific pipeline version

    # Test profile (includes test data and configuration)
    "-profile" "test,singularity"    # test = use built-in test data
                                     # singularity = use Singularity containers

    # OSC configuration
    "-c" "osc.config"                # OSC SLURM configuration

    # Output directory
    "--outdir" "./results"           # Output directory for results
)

# Run the pipeline
nextflow run nf-core/rnaseq "${PARAMS[@]}"

echo ""
echo "=== Test run complete! ==="
echo "Check results in: ./results"
echo "If successful, you're ready to run with real data"
