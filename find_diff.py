import sys
import operator

def find_topN(filename, N):
	diff = open(filename, 'r')
	output = open("SUMMARY.TXT", 'w')
	diffMap = {}

	first = True
	for line in diff:

		# Skip the header
		if first:
			first = False
			continue

		split = line.split("\t")
		if split[2] == "NaN" or split[9] == "-inf" or split[9] == "inf" or split[13] == "no":
			continue

		diffMap[split[2].strip()] = (abs(float(split[9])), float(split[9]))
	keyAbs = lambda (key,(absvalue,value)):absvalue

	newDiff = sorted(diffMap.items(), key=keyAbs, reverse=True)
	
	count = 0
	num = int(N)
	output.write("Gene\t\tLog2FoldChange\n")
	for element in newDiff:
		output.write(element[0] + "\t\t" + str(element[1][1]) + "\n")
		count = count + 1
		if (count >= num):
			break
	output.flush()


args = sys.argv
N = args[1]
filename = args[2]
find_topN(filename, N)