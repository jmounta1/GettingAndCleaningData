# new DeSeq analysis using Bioconductor DESeq2
# input is raw data from ion torrent server
# script normalizes counts in DESeq2 package, runs differential expression analysis

# load packages
library(DESeq2)
library(tidyverse)
library(GSEABase)

# read in data
raw <- read.table('C:/Users/jmounta1/Downloads/Auto_UC5_Iressa_24hr_-_Kai_torrent-server_322.bcmatrix.xls', header = T)

# parse only matrix of raw counts, add pseudocount
cts <- as.matrix(raw[ ,3:10])

#headers for UC5 Iressa experiment, just for reference
headers <- c('Kai_DMSO_1','Kai_DMSO_2','Kai_DMSO_3','Kai_Iressa_1','Kai_Iressa_2','Kai_Iressa_3','Jack_DMSO_1',
                        'Jack_Iressa_1')

#normalize raw counts log2
ctnorm <- rlogTransformation(cts)
colnames(ctnorm) <- headers

# convert raw counts to DESeqDataSet
col_Data <- data.frame('condition' = c(rep('DMSO', 4), rep('Ir', 4)))
col_Data <- transform(col_Data, condition = factor(condition))
dds <- DESeqDataSetFromMatrix(countData = cts,
                         colData = col_Data,
                         design = ~ condition)
rowData(dds) <- raw$Gene

dds2 <- DESeq(dds)

# log2 normalization of count data
rld <- rlogTransformation(dds2)
head(assay(rld))
hist(assay(rld))

# standard differential expression analysis
res <- results(dds2)

#order res based on padj
res_order <- res[order(res$padj), ]


# hierarchical clustering
counts_T <- t(ctnorm)
distxy <- dist(counts_T)
my_cluster_complete <- hclust(distxy, method = "complete")
my_cluster_average <- hclust(distxy, method = "average")
my_cluster_single <- hclust(distxy, method = "single")
par(mar = c(0,0,0,0))
png('C:/Users/jmounta1/Downloads/UC5_clustering.png')
plot(my_cluster_complete, main = "UM-UC5 RNAseq Clustering")
plot(my_cluster_average, main = "Average Method")
plot(my_cluster_single, main = "Single Method")
dev.off()



## file output for use in Morpheus
morpheus_headers <- c('Gene','Kai_DMSO_1','Kai_DMSO_2','Kai_DMSO_3','Kai_Iressa_1','Kai_Iressa_2','Kai_Iressa_3','Jack_DMSO_1',
                      'Jack_Iressa_1')
formatted <- data.frame(raw$Gene, raw[,3:10])
colnames(formatted) <- morpheus_headers
write.table(formatted,'C:/Users/jmounta1/Downloads/UC5_Iressa_formatted.txt', row.names = F, col.names = T)
EMTgenes <- scan('C:/Users/jmounta1/Downloads/geneset_EMT.txt', what = character(), skip = 2)
EMTplus <- c(EMTgenes, 'extragene')

formatted_EMT <- formatted %>%
  subset(formatted$Gene %in% EMTgenes)
#sum(formatted$Gene %in% EMTgenes)
#194
write.table(formatted_EMT, 'C:/Users/jmounta1/Downloads/UC5_Iressa_formatted_EMTsub.txt', row.names = F, col.names = T)

#normalize counts to import to morpheus (normalize whole dataset first, then subset into EMT genes)
ctnorm <- rlogTransformation(cts)
form_norm <- data.frame(raw$Gene, ctnorm)
colnames(form_norm) <- morpheus_headers

