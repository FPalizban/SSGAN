version 1.0


workflow SNV_calling {
  call mutect2
}
task mutect2 {
  input {
    File inputfastq_normal1
    File inputfastq_normal2
    String sampleName_normal
    String sampleName_tumor
    String sampleName
    File inputfastq_tumor1
    File inputfastq_tumor2
    File ref_fasta
    File ref_fasta_index
    File ref_dict
    File? ref_alt
    File ref_amb
    File ref_ann
    File ref_bwt
    File ref_pac
    File ref_sa
    File picard
    File gatk
  }
  command {
     bwa mem -M -K 100000000 ${ref_fasta} ${inputfastq_normal1} ${inputfastq_normal2} > ${sampleName_normal}.sam && samtools view -S -b ${sampleName_normal}.sam > ${sampleName_normal}.bam && java -jar ${picard} AddOrReplaceReadGroups I= ${sampleName_normal}.bam O= ${sampleName_normal}_RG.bam RGID=4 RGLB=twist RGPL=illumina RGPU=unit1 RGSM=${sampleName_normal} && java -jar ${picard} SortSam I= ${sampleName_normal}_RG.bam O=${sampleName_normal}_RG_sorted.bam SORT_ORDER=coordinate &&  java -jar ${picard} BuildBamIndex I= ${sampleName_normal}_RG_sorted.bam && java -jar ${picard} MarkDuplicates I= ${sampleName_normal}_RG_sorted.bam O= ${sampleName_normal}_dedup.bam M=${sampleName_normal}_dup_metrics.txt && java -jar ${picard} BuildBamIndex I= ${sampleName_normal}_dedup.bam && bwa mem -M -K 100000000 ${ref_fasta} ${inputfastq_tumor1} ${inputfastq_tumor2} > ${sampleName_tumor}.sam && samtools view -S -b ${sampleName_tumor}.sam > ${sampleName_tumor}.bam && java -jar ${picard} AddOrReplaceReadGroups I= ${sampleName_tumor}.bam O= ${sampleName_tumor}_RG.bam RGID=4 RGLB=twist RGPL=illumina RGPU=unit1 RGSM=${sampleName_tumor} && java -jar ${picard} SortSam I= ${sampleName_tumor}_RG.bam O=${sampleName_tumor}_RG_sorted.bam SORT_ORDER=coordinate &&  java -jar ${picard} BuildBamIndex I= ${sampleName_tumor}_RG_sorted.bam && java -jar ${picard} MarkDuplicates I= ${sampleName_tumor}_RG_sorted.bam O= ${sampleName_tumor}_dedup.bam M=${sampleName_tumor}_dup_metrics.txt && java -jar ${picard} BuildBamIndex I= ${sampleName_tumor}_dedup.bam &&java  -jar ${gatk} Mutect2 -R ${ref_fasta} -I ${sampleName_normal}_dedup.bam -I ${sampleName_tumor}_dedup.bam -O ${sampleName}.vcf.gz
   }
  output {
    File normal_dedup_bam = "${sampleName_normal}_dedup.bam"
    File tumor_dedup_bam = "${sampleName_tumor}_dedup.bam"
    File normal_dedup_bai = "${sampleName_normal}_dedup.bai"
    File tumor_dedup_bai = "${sampleName_tumor}_dedup.bai"
    File VCF = "${sampleName}.vcf.gz"
  }
}


