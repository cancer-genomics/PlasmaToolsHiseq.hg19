args <- commandArgs(trailingOnly = TRUE)
datadir <- args[1]
outfile <- args[2]

### Create weights from reference file
library(data.table)
library(tidyverse)
setDTthreads(1)

#refids <- read_csv("../ReferenceIDs_healthies_for_z_scores.csv")
#refids <- refids %>% filter(!is.na(psomagen_submission))
#refids <- refids$pgdx_id

#datadir <- "/dcl02/leased/cglab/rscharpf/cristiano/projects/lucas/panel-of-normal/gc-counts/"
#ref20_paths <-paste(datadir,refids,"_gc.csv",sep="")
#write_csv(data.frame(ref20_paths),"ref20_paths.csv")

ref20_paths <- read_csv("ref20_paths.csv")

x <- rbindlist(lapply(as.list(ref20_paths)[[1]], fread))
x[,prob:=n/sum(n),by=.(id, seqnames)]
x[,prob2:=cumsum(prob),by=.(id, seqnames)]

x <- x[,.(n=sum(n)),by=.(id, gc, seqnames)]
x <- x[grepl("P$|P1$", id)]
mediandt <- x[,.(gcmed=median(n)),by=.(seqnames, gc)]
mediandt[,seqnames:=factor(seqnames, c(paste0("chr", 1:22), "chrX", "chrY"))]
mediandt[order(seqnames, gc)]
fwrite(mediandt, outfile)

# setkey(mediandt, gc, seqnames)
# setkey(x, gc, seqnames)
# x <- x[mediandt][order(id, seqnames, gc)]
# x[,w:=gcmed/n,  by=.(id,  seqnames)]
# 
# fwrite(x, outfile)
