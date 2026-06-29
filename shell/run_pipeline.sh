#!/bin/bash

# -----------------------------
# Clinical Genomics Pipeline
# -----------------------------

set -e

cd "$(dirname "$0")/.."

PIPELINE=$1

echo "Starting pipeline: $PIPELINE"

if [ "$PIPELINE" == "sniffles" ]; then
    nextflow run ./nextflow/sniffles/main.nf \
      -with-apptainer \
      -resume

elif [ "$PIPELINE" == "clair3" ]; then
    nextflow run ./nextflow/clair3/main.nf \
      -with-apptainer \
      -resume

else
    echo "Usage: bash run_pipeline.sh [sniffles|clair3]"
    exit 1
fi

echo "Pipeline finished successfully"
