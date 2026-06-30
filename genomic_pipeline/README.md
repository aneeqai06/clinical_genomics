# Clinical Genomics Pipeline

A modular Nextflow-based clinical genomics pipeline for long-read sequencing data. This repository provides two alternative workflows:

* **Sniffles** – Structural Variant (SV) calling
* **Clair3** – SNP and INDEL calling

Both workflows share the same alignment and BAM preprocessing steps while using different variant callers.

---

## Repository Structure

```text
clinical_genomics/
├── nextflow/
│   ├── clair3/
│   │   └── main.nf
│   └── sniffles/
│       └── main.nf
├── script/
│   ├── alignment.def
│   └── sniffles.def
├── shell/
│   └── run_pipeline.sh
├── .gitignore
└── README.md
```

---

## Requirements

* Nextflow
* Apptainer (or Singularity)
* Linux or WSL

---

## Input Data

Input sequencing reads and the reference genome are **not included** in this repository. Users should provide their own FASTQ files and reference genome before running the workflows.

---

## Containers

Apptainer (`.sif`) container images are **not included** because they are large binary files and are excluded from version control.

Build the required containers from the provided definition files or obtain compatible container images before running the pipelines.

---

## Running the Pipelines

Run the Sniffles workflow:

```bash
bash shell/run_pipeline.sh sniffles
```

Run the Clair3 workflow:

```bash
bash shell/run_pipeline.sh clair3
```

---

## Workflow Overview

Both workflows perform:

1. Read alignment using Minimap2
2. BAM sorting and indexing using Samtools
3. Variant calling

   * **Sniffles** for structural variants
   * **Clair3** for SNP and INDEL detection

---

## Output

* **Sniffles:** Variant Call Format (VCF) file containing structural variants.
* **Clair3:** Compressed VCF (`merge_output.vcf.gz`) containing SNP and INDEL calls.

Intermediate files, generated outputs, containers, and Nextflow work directories are excluded from version control via `.gitignore`.

