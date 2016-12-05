## Project Details
Our project automates and streamlines an RNA-seq pipeline by using bash scripting and python modules. The user can run our script giving the input as their samples of interest along with the reference genome of the samples that they have. The script will run several bioinformatics tools that are used in differential expression analysis. After the script is finished executing, the user will have a list of files. Contained in this list is a summary file that shows N of the most differentially expressed genes that are also significant (have a p-value of < 0.05). The main purpose of our program is to simplify the execution of RNA-seq pipelines, which can often have a steep learning curve for people who have never used a command-line environment. Various parameters and formats can also be confusing and overwhelming to new users. With the use of our program, the user can easily give input and using a single command, run an entire pipeline and receive a differential expression analysis of their samples. Given the input and a single command, our program can run an entire pipeline and provide a differential expression analysis of the samples.

Our program will prompt the user with questions regarding their samples. It will ask whether the samples are single or paired-end reads, the insert size if it differs from the default, the reference genome used in the form of a .fasta file, and the samples in the form of .fastq files. Since this program will generate the N most differentially expressed genes that are biologically significant, it will prompt the user to enter what N should be. Once the program has the information necessary, it enters the first stage of the pipeline and performs the alignment of mRNA reads to the given reference genome using TopHat [1]. Next in the RNA-seq pipeline, it utilizes Cufflinks [2] to assemble the transcripts. This stage outputs a separate file of assembled transcripts for each file. In order to merge these together, Cuffmerge [3] is called on the files. In order to identify the differentially expressed genes, Cuffdiff [2] is called next. This outputs a file containing information regarding the genes, such as the log2 fold change, and p-value. This output is parsed by extracting the top N most differentially expressed genes with a p-value that is less than 0.05. It is written to a user friendly file that can be easily opened and interpreted.

## How to Run

In order to use our program, you would need to download Samtools, Bowtie, Tophat, Cufflinks, Cuffmerge, and Cuffdiff and add the variables bowtie, tophat, and cufflinks to your PATH. Additionally, you need to have Python installed on your machine. Following, to use our pipeline, simply run the script by typing into your terminal:
```$ ./rna_seq_pipeline.sh```
Again, you will be prompted to enter several different input files, such as your .fastq samples and your .fasta reference files, and the optional parameters to run the pipeline. Once you have gone through the series of prompts, the program will execute the tools to run the pipeline.

## Motivation
The purpose of our program is to automate and simplify the execution of an RNA-seq pipeline. Withoutthisstreamlinedprogram,userswouldhavetoenteracommand,waitseveral hours for a command to finish before having to return to the computer and enter the next command. In addition to not having to execute the different tools separately, this program simplifies the pipeline by prompting the users for exactly what is needed, which eliminates the confusion regarding how to execute these tools. It abstracts away the complex underlying details of the programs run, and acts as a user-friendly interface. Due to the fact that RNA-seq data has a very high throughput, the program takes approximately a couple of hours to complete running the pipeline on a realistic dataset. With that being said, our program doesn’t deviate far from the average time that it usually takes to complete a differential expression analysis. It merely streamlines the execution of several bioinformatics tools. Some of the drawbacks of our pipeline is the fact that the user cannot specify extra optional parameters if they would like to, as the program will automatically run the pipeline for them. Because we add abstraction to simplify the pipeline, we restrict the users freedom with running these tools. Additionally, our program only allows the user to perform a differential expression analysis between 2 samples, so if the researcher has multiple samples they would have to run this pipeline multiple times.


## Notes
On our own machines, we tested with files retrieved from the NCBI database (​https://blast.ncbi.nlm.nih.gov/Blast.cgi​) , but were unable to upload it to the Github repo.
For testing purposes, feel free to use the test data we provided within our repo:
- reads_1.fq
- reads_2.fq
- test_ref.fa

## Contributors
- Karina Soerjanto
- Cherie Huang
- Dennis Cao
- Katie Huang
