library("pracma")

source("select_file_csv.R")
source("plot_morphology_matrix.R")

csvFileName <- select_file_csv()
if (csvFileName == "!") {
  return()
}

idx <- strfind(csvFileName, "ARA")
if (length(idx) > 0) {
  plotLabel <- "ARA_Old"
} else {
  plotLabel <- "Atlas_V3"
}

cells <- read.csv(file=csvFileName, header=TRUE, sep=",")
print(cells)

nRows <- nrow(cells)
nColumns <- ncol(cells)

neuronLabels <- cells[1:nRows,1]
print(neuronLabels)

parcelLabels <- colnames(cells)
parcelLabels <- parcelLabels[2:nColumns]
print(parcelLabels)

morphologyMatrix <- cells[1:nRows,2:nColumns]
print(morphologyMatrix)

plot_morphology_matrix(morphologyMatrix, neuronLabels, parcelLabels, plotLabel)