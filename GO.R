library("GOSemSim")
library(parallel)

# Calculate the number of cores
no_cores <- detectCores() - 1

# Initiate cluster
cl <- makeCluster(no_cores)
hsGO <- godata('org.Hs.eg.db', keytype = "SYMBOL", ont="BP")
hgnc <- read.csv("hgnc_complete_set.txt", sep="\t")
#genes = slot(hsGO, "keys")
genes <- unique(slot(hsGO, "geneAnno")$SYMBOL)
approved <- hgnc[hgnc$status == "Approved",]
g <- genes[genes %in% approved$symbol]
ngenes = length(g)
print(ngenes)
clusterExport(cl, list("geneSim", "hsGO"))
f = file("GO_BP_Rel.csv", open="w")
for (i in 1:ngenes) {
    g1 <- g[i]
    others = g[(i+1):ngenes]
    aux_fun = function(g2, g1) {
        out <- geneSim(g1, g2, semData=hsGO, measure="Rel", combine="max", drop=NULL)
    	if (!is.na(out)) {
    		out$geneSim
	} else {
		NULL
	}
    }
    res = parLapply(cl, others, aux_fun, g1)
    sim = res[!is.null(res)]
    others = others[!is.null(res)]
    for (j in 1:length(others)) {
        write.table(t(c(g1, others[j], sim[j])), file=f, row.names=FALSE, col.names=FALSE, sep=",", quote=FALSE)
    }
}
