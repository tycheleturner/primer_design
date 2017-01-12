#!/bin/Rscript
#Author: Tychele N. Turner, Ph.D.
#Original date: September 29, 2016

library("optparse")
library('seqinr')

option_list <- list(
	make_option(c('-f', '--fastaFile'), action='store', type='character', default='myfile', help='Input fasta file where you want to add brackets at 500 bp in from each side'),
        make_option(c('-o', '--outputFile'), action='store', type='character', default='outfile', help='Output file ready for Primer3')
)
opt <- parse_args(OptionParser(option_list = option_list))
 
fastaFile = opt$fastaFile
outfile = opt$outputFile

datafile <- read.fasta(fastaFile)

piece1 <- list()
piece2 <- list()
piece3 <- list()
final <- list()

for(i in 1:length(datafile)){
	piece1[[i]] <- paste(datafile[[i]][c(1:500)], collapse="")
	piece2[[i]] <- paste(datafile[[i]][c(501:(length(datafile[[i]])-500))], collapse="")
	piece3[[i]] <- paste(datafile[[i]][c((length(datafile[[i]])-499):(length(datafile[[i]])))],collapse="")
}

for(i in 1:length(piece1)){
	final[[i]] <- paste(piece1[[i]], "[", piece2[[i]], "]", piece3[[i]], sep="")
}

write.fasta(final, file.out=outfile, names=names(datafile))

