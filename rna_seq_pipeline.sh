
echo "What is the name of this species?"
read species_name

echo "Is this genome single ended or pair ended. Press s for single ended, p for pair ended:"
read ended
#loop until the user input is valid
while [ $ended != 'p' -a $ended != 's' ];
	do
		echo "Please enter 's' or 'p' only"
		read ended
	done

if [ $ended == 's' ]
	then
		echo "What is the path to the first read"
		read first_fq
		until [ -e $first_fq ]; do
			echo "That does not exist, try again"
			read first_fq
		done

		echo "What is the path to the second read"
		read second_fq
		until [ -e $second_fq ]; do
			echo "That does not exist, try again"
			read second_fq
		done
	fi
if [ $ended == 'p' ]
	then
		echo "What is the path to the first_1 read"
		read first_1_fq
		until [ -e $first_1_fq ]; do
			echo "That does not exist, try again"
			read first_1_fq
		done
		echo "What is the path to the first_2 read"
		read first_2_fq
		until [ -e $first_2_fq ]; do
			echo "That does not exist, try again"
			read first_2_fq
		done
		echo "What is the path to the second_2 read"
		read second_1_fq
		until [ -e $second_1_fq ]; do
			echo "That does not exist, try again"
			read second_1_fq
		done
		echo "What is the path to the second_2 read"
		read second_2_fq
		until [ -e $second_2_fq ]; do
			echo "That does not exist, try again"
			read second_2_fq
		done
	fi

echo "What is the path to the reference .fa file?"
read fa
until [ -e $fa ]; do
	echo "That does not exist, try again"
	read fa
done

echo "How many of the most differentially expressed genes would you like to see"
read number_diff

echo "Creating Bowtie indexes..."
bowtie2-build $fa $species_name
echo "Bowtie indexes created."

echo "Moving index files to separate folder"
mkdir $species_name
mv $species_name*.bt2 $species_name
cp $fa $species_name/$species_name.fa
echo "Moving done."

echo "Running tophat"
if [ $ended == 's' ]
	then
		echo "Running tophat single"
		tophat2 -o first $species_name/$species_name $first_fq 
		tophat2 -o second $species_name/$species_name $second_fq
	fi
if [ $ended == 'p' ]
	then
		echo "Running tophat double"
		tophat2 -o first $species_name/$species_name $first_1_fq $first_2_fq
		tophat2 -o second $species_name/$species_name $second_1_fq $second_2_fq
	fi
echo "Tophat done."

echo "Running Cufflinks"
cufflinks first/accepted_hits.bam
mv transcripts.gtf first/
cufflinks second/accepted_hits.bam
mv transcripts.gtf second/

touch assemblies.txt
echo "first/transcripts.gtf" > assemblies.txt
echo "second/transcripts.gtf" >> assemblies.txt
echo "Done running Cufflinks"

echo "Running Cuffmerge"
cuffmerge assemblies.txt
echo "Done running Cuffmerge"
cd merged_asm
cuffdiff merged.gtf ../first/accepted_hits.bam ../second/accepted_hits.bam

cd ..
echo "Sorting the top $number_diff most significant genes"
python find_diff.py $number_diff merged_asm/gene_exp.diff