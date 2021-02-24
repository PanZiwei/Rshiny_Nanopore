suppressPackageStartupMessages(library(DT))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(dplyr))

column_names <-c("Dataset", "Chrom", "Start", "End", "Strand",
                 "5mC%_BSseq", "5mC%_DeepSignal",'5mC%_Nanopolish','5mC%_Tombo', '5mC%_DeepMod', '5mC%_DeepMod_clust',
                 "Singleton", "CpG_island", "Genome_location")
chrOrder <- c(paste("chr",1:22,sep=""),"chrX","chrY")

data.table::setDTthreads(0L) 
df <- data.table::fread(input='./data/NA19240.APL.HL60.tsv.bz2', sep="\t")
data.table::setnames(df, column_names)
df$Chrom <- factor(df$Chrom, levels=chrOrder)
df <- df[order(df$Chrom),]
df %>% dplyr::mutate_if(is.character,funs(factor(.)))


options(DT.options = list(columnDefs = list(list(className = 'dt-center', width = '6%', targets = "_all")),
                          pageLength = 25,  
                          lengthMenu = c(25, 50, 75),
                          scrollX = T))

