args <- commandArgs(trailingOnly = TRUE)
datadir <- args[1]
outfile <- args[2]

### Create weights from reference file
library(data.table)
setDTthreads(1)

x <- rbindlist(lapply(list.files(datadir, pattern=".csv", full.names=TRUE), fread))
x[,prob:=n/sum(n),by=.(id, size)]
x[,prob2:=cumsum(prob),by=.(id, size)]

x <- x[,.(n=sum(n)),by=.(id, gc, size)]
x <- x[grepl("P$|P1$", id)]
mediandt <- x[,.(gcmed=median(n)),by=.(size, gc)]
# mediandt[,seqnames:=factor(seqnames, c(paste0("chr", 1:22), "chrX", "chrY"))]
mediandt[order(gc)]
fwrite(mediandt, outfile)

# setkey(mediandt, gc, seqnames)
# setkey(x, gc, seqnames)
# x <- x[mediandt][order(id, seqnames, gc)]
# x[,w:=gcmed/n,  by=.(id,  seqnames)]
# 
# fwrite(x, outfile)
