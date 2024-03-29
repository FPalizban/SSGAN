# Semi-supervised GAN (SSGAN) for cfDNA somatic mutation labeling


## Introduction
In the current research, we have developed a generative model-based tool for simulating the cfDNA SNVs and labeling each real cfDNA SNV as a tumor or CH. For this aim the real cfDNA NGS data which can be WGS, WES, and targeted sequencing will go under somatic variant calling with any proposed best practices, especially the one that is implemented by GATK and then the raw VCF files will be filtered based on the criteria that are explained in our manuscript. Next, the genomic coordination along with the nucleotide composition information will be extracted and used for training the GAN part of our model.
For the labeling part of our model, we have collected the validated tumor or CH-related variants from several databases and articles, and the same feature vector was prepared for each of them and fed to our semi-supervised part of our model.

![Image](sgan_model.jpg "icon")

## Repository Navigation Guide

### Script

•	SSGAN: A repository dedicated to training and validating SSGAN for somatic mutation labeling using both labeled and unlabeled data.

•	Preprocessing: Performs preprocessing on both labeled and unlabeled data. Unlabeled data in xlsx format of VCF files requires an additional preprocessing step compared to labeled data.

•	Train: The training function takes the model, data, and hyperparameters as input and trains the model. Two distinct functions for unsupervised and supervised training. GAN model trains on unlabeled data. Classifier trains on labeled data.

•	Model: Implements the SSGAN structure and essential functions in the .py file.

### Data
•	Unlabeled and labeled data serve as inputs for the model, both in xlsx format.
•	Each xlsx file corresponds to a .txt file containing approximately 20 upstream and downstream nucleotides.
### Glioma
•	Glioma data is used for validating the GAN as a pre-trained model.
### Example Classification
•	Demonstrates somatic mutation classification in VCF files using the classifier engine of SSGAN. This folder includes sample VCF, code, and label predictions.
### Example Generating
•	The generator for the GAN is trained on somatic mutations, enabling the generation of somatic mutations using this engine. This folder includes code and 1000 sample mutations generated.
### Model Weights
•	Generator, discriminator, GAN, and classifier models are saved in .keras format for further validations and usage.

## Somatic Mutation Classification

• Upload your chosen VCF dataset into the '/Example Classification/' folder in xlsx format. Additionally, upload the corresponding .txt file, which includes 20 upstream and downstream nucleotides. 

• Utilize the notebook '/Example Classification/Classification.ipynb' for labeling mutations.

## Generating Somatic Mutations

• Employ the notebook '/Example Generating/Generator.ipynb' for generating somatic mutations. 

• The output of the generator is a CSV file containing information on position, chromosome, alternative, and reference nucleotides.


## Installation

The SSGAN model is written in python3 and needs the below packages before running:\
numpy\
pandas\
tensorflow\
matplotlib\
All the packages can be easily installed via terminal by:\
$ pip3 install "package name"

## Prepare input data

First, the raw NGS data should go under the somatic variant calling process based on GATK best practices as the workflow attached in .wdl file. Then, the VCF file obtained from cfDNA genomic data needs to be filtered based on the mentioned criteria in our article:

1)	SNV: variants had to meet the criterion of being only SNV for inclusion in the subsequent analysis and indels were not considered in this study.
2)	Human chromosomes: only variants associated with the 23 pairs of chromosomes and the mitochondrial genome were retained and other scaffolds in the reference genome were ignored.
3)	High depth: variants were further filtered to ensure they exhibited a high depth, with a depth exceeding 30.

The file in Excel is like the unlabeled files in the data folder. Then only the first four columns will be used in the model.\
Next, to extract the nucleotide composition around the SNV position GRCH38 and samtools are needed.\
$ sudo apt install samtools\
Then extract the nucleotide composition around the SNVs by samtools faidx and awk commands which will be ready as -seg.txt files in the data folder.



