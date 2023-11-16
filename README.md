# SSGAN for somatic-mutation-labeling

In the current research, we have developed a generative model-based tool for simulating the cfDNA SNVs and labeling each real cfDNA SNVs as a tumor or CH.
For this aim the real cfDNA NGS data which can be WGS, WES, and targeted sequencing will go under somatic variant calling with any proposed best practices, especially the one that is implemented by GATK and then the raw VCF files will be filtered based on the criteria that are explained in our manuscript. Next, the genomic coordination along with the nucleotide composition information will be extracted and used for training the GAN part of our model.\
For the labeling part of our model, we have collected the validated tumor or CH-related variants from several databases and articles, and the same feature vector was prepared for each of them and fed to our semi-supervised part of our model.
## Extracting the nucleotide composition for each SNV
$ samtools faidx Homo_sapiens.GRCh38.dna.primary_assembly. fa -r SNV_list.txt > ch-seq.txt

## Running SSGAN
To run the SSGAN, there are related input files in the inputs folder which can be used. If you want to use it on a new sample, first apply the somatic variant calling and filtration on the obtained VCF file and then extract the nucleotide composition based on the above-mentioned command and prepare your raw file as the one in the inputs folder. With this approach, you can apply the SSGAN script to your own data.
