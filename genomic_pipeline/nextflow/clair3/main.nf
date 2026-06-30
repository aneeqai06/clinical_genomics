nextflow.enable.dsl=2

params.reads = "nextflow/input/*.fastq"
params.ref   = "nextflow/input/hg38.fa"

process ALIGN {

    container "${projectDir}/../containers/alignment.sif"

    input:
    path fastq
    path ref

    output:
    path "aln.sam"

    script:
    """
    minimap2 -ax map-hifi $ref $fastq > aln.sam
    """
}

process SAMTOOLS_SORT {

    container "${projectDir}/../containers/alignment.sif"

    input:
    path sam

    output:
    tuple path("sorted.bam"), path("sorted.bam.bai")

    script:
    """
    samtools view -bS $sam | samtools sort -o sorted.bam
    samtools index sorted.bam
    """
}
process CLAIR3 {

    container "${projectDir}/../containers/clair3_v2.0.1.sif"

    cpus 4

    input:
    tuple path(bam), path(bai)
    path ref

    output:
    path "clair3_output/merge_output.vcf.gz"
    path "clair3_output/merge_output.vcf.gz.tbi"

    script:
    """
    run_clair3.sh \
        --bam_fn=$bam \
        --ref_fn=$ref \
        --threads=${task.cpus} \
        --platform=hifi \
        --model_path=/opt/models/hifi \
        --output=clair3_output
    """
}

workflow {

    fastq_ch = Channel.fromPath(params.reads)
    ref_ch   = Channel.fromPath(params.ref)

    align_ch  = ALIGN(fastq_ch, ref_ch)

    sorted_ch = SAMTOOLS_SORT(align_ch)

    CLAIR3(sorted_ch, ref_ch)
}
