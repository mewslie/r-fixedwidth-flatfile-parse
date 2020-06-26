#manually enter paths, files, file attributes etc
file.index <- file.path("C:\\File\\Path\\Here", "filename.txt")
file.colwidth1 <- 12 #max characters in first column
file.colwidth2 <- 600 #max characters in second column, manually count or use really big number
entry.delimiter <- "///" #separator character between each entry (reaction, gene, protein etc)

#read file.index into a dataframe where rows are lines in file, cols are columns as defined by file.colwidth1 and file.colwidth2
file.flat <- read.fwf(file.index, fill = T, strip.white = T, widths = c(file.colwidth1, file.colwidth2))

#separate file.index into a list of dataframes that represent an entry by getting the line number of the limiters
block.ind <- which(file.flat$V1 == entry.delimiter) #lines before this index is a "block" of info for 1 entry
block.ind <- c(1, block.ind)

#parse blocks of file.flat into list of lists
library("stringr")
entry.list <- list()
for (i in 2:length(block.ind)) {
  bloc <- file.flat[(block.ind[i-1]):(block.ind[i]-1),]
  features <- unique(bloc$V1[bloc$V1!=""]) #will be colnames
  features.ind <- which(bloc$V1 %in% features) #row index of features
  features.ind <- c(features.ind, nrow(bloc)+1)
  bloc.list <- list()
  for (r in 1:(length(features.ind)-1)) {
    values <- bloc$V2[features.ind[r]:(features.ind[r+1]-1)]
    bloc.list <- c(bloc.list,list(values))
  }
  names(bloc.list) <- features
  entry.list <- c(entry.list, list(bloc.list))
}
