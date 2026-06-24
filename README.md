# Clinical Genomics Structural Variant Pipeline

## Overview

This project implements a structural variant (SV) calling pipeline using Nextflow and Apptainer/Singularity containers.

The workflow:

1. Aligns PacBio HiFi reads to the human reference genome using Minimap2.
2. Converts and sorts alignments using Samtools.
3. Calls structural variants using Sniffles2.
4. Produces a VCF file containing detected structural variants.

---

## Pipeline Workflow

FASTQ → Minimap2 → SAMtools Sort/Index → Sniffles2 → VCF

---

## Directory Structure

```text
clinical_genomics/
├── nextflow/
│   └── main.nf
├── script/
│   ├── alignment.def
│   └── sniffles.def
├── shell/
│   └── run_pipeline.sh
└── .gitignore
```

---

## Requirements

* Nextflow
* Apptainer/Singularity
* Minimap2
* Samtools
* Sniffles2

Container definitions are provided in:

* script/alignment.def
* script/sniffles.def

---

## Input Files

Required input files:

* Human reference genome (hg38.fa)
* PacBio HiFi FASTQ file

Place input files in the input directory specified in the pipeline configuration.

---

## Running the Pipeline

Execute:

```bash
bash shell/run_pipeline.sh
```

Or run Nextflow directly:

```bash
nextflow run nextflow/main.nf -with-apptainer
```

---

## Output

The pipeline generates:

* Sorted and indexed BAM files
* Structural variant calls in VCF format

---

## Author

Aneeqa
Clinical Genomics Project

