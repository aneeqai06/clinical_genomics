#!/bin/bash

# -----------------------------
# Clinical Genomics Pipeline
# -----------------------------

set -e  # stop if any error happens

echo "Starting pipeline..."

# move to project root (important)
cd "$(dirname "$0")/.."

# run Nextflow pipeline
nextflow run ./nextflow/main.nf \
  -with-apptainer \
  -resume

echo "Pipeline finished successfully"
