# SSGAN for somatic-mutation-labeling

In the current research we have developed a generative model based tool for simulating the cfDNA SNVs and label each real cfDNA SNVs as tumor or CH.
For this aim the real cfDNA NGS data which can be WGS, WES, and targeted sequencing will go under somatic variant calling with any proposed best-practices specially the one that is implemented by GATK and then the raw VCF files will be filtered based on the critera that are explaiend in our manuscript. Next, the genomic coordination along with the nucleotide composition information will be extracted and used for training the GAN part of our model.\
For 
