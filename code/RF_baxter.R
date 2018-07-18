deps = c("pROC","randomForest","AUCRF","knitr","rmarkdown","vegan","gtools");
for (dep in deps){
  if (dep %in% installed.packages()[,"Package"] == FALSE){
    install.packages(as.character(dep), quiet=TRUE);
  }
  library(dep, verbose=FALSE, character.only=TRUE)
}

tax <- read.delim('data/mothur/glne007.0.03.trim.tax', sep='\t', header=T, row.names=1)
meta <- read.delim('data/mothur/metadata.tsv', header=T, sep='\t')
shared <- read.delim('data/mothur/glne007.final.opti_mcc.unique_list.0.03.subsample.0.03.filter.shared', header=T, sep='\t')

all_data <- merge(meta, shared, by.x='sample', by.y='Group')
all_data$lesion <- factor(NA, levels=c(0,1))
all_data$lesion[all_data$dx=='adenoma' | all_data$dx=='cancer'] <- 1
all_data$lesion[all_data$dx=='normal'] <- 0