nextflow.enable.dsl=2

params.reads = "nextflow/input/*.fastq"
params.ref   = "nextflow/input/hg38.fa"


process ALIGN {

    container "${projectDir}/containers/alignment.sif"

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

    container "${projectDir}/containers/alignment.sif"

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
process SNIFFLES {

    container "${projectDir}/containers/sniffles.sif"

    input:
    tuple path(bam), path(bai)

    output:
    path "variants.vcf"

    script:
    """
    sniffles -i $bam -v variants.vcf
    """
}


workflow {

    fastq_ch = Channel.fromPath(params.reads)
    ref_ch   = Channel.fromPath(params.ref)

    align_ch  = ALIGN(fastq_ch, ref_ch)

    sorted_ch = SAMTOOLS_SORT(align_ch)

    SNIFFLES(sorted_ch)
}
