library("ggplot2")

hatch_lines <- function(morphologyInvasion, nNeurons, nParcels) {
  for (i in 1:nNeurons) {
    for (j in 1:nParcels) {
      ### add horizontal white lines to neurite locations with axons
      if ((morphologyInvasion[i,j] == 1) | (morphologyInvasion[i,j] == 3)) {
        segments(j-0.4, i, j+0.4, i, col = "white", lwd = 2.0)
      }
      
      ### add vertical white lines to neurite locations with dendrites
      if ((morphologyInvasion[i,j] == 2) | (morphologyInvasion[i,j] == 3)) {
        segments(j, i-0.4, j, i+0.4, col = "white", lwd = 2.0)
      }
    }
  }
  
  for (i in 0:nNeurons+1) {
    segments(0.5, i-0.5, nParcels+0.5, i-0.5, col = "black", lwd = 1.0)
  }
  
  for (j in 0:nParcels+1) {
    segments(j-0.5, 00.5, j-0.5, nNeurons+0.5, col = "black", lwd = 1.0)
  }
}

plot_morphology_matrix <- function(morphologyMatrix, neuronLabels, parcelLabels, plotLabel) {
  
  DG <- 1
  CA3 <- 2
  CA2 <- 3
  CA1 <- 4
  SUB <- 5
  EC <- 6
  
  BLACK <- "#000000"
  BLUE <- "#0000FF"
  BLUE_DARK <- "#000080"
  BLUE_MEDIUM <- "#0000C0"
  BLUE_LIGHT <- "#8FACFF"
  BLUE_SKY <- "#00CCFF"
  BLUE_UBERLIGHT <- "#E3E9FF"
  BLUE_ULTRALIGHT <- "#C7D6FF"
  BROWN <- "#996633"
  BROWN_DG <- "#5B2D0A"
  BROWN_DG_MEDIUM <- "#7C3D0E"
  BROWN_DG_LIGHT <- "#9A4A11"
  BROWN_CA3 <- "#A5836B"
  GRAY <- "#808080"
  GRAY_DARK <- "#404040"
  GRAY_MEDIUM <- "#606060"
  GRAY_LIGHT <- "#C0C0C0"
  GRAY_ULTRALIGHT <- "#E6E6E6"
  GREEN <- "#008000"
  GREEN_MEDIUM <- "00C000"
  GREEN_BRIGHT <- "00FF00"
  GREEN_EC <- "#6A9531"
  GREEN_MEC <- "#7ABB33"
  GREEN_LEC <- "#5A6F2F"
  ORANGE <- "#E46C0A"
  ORANGE_LIGHT <- "#F79C15"
  ORANGE_CA1 <- "#D9680D"
  PURPLE <- "#800080"
  PURPLE_DARK <- "#400040"
  PURPLE_LIGHT <- "#B280B2"
  PURPLE_UBERLIGHT <- "#ECE0EC"
  PURPLE_ULTRALIGHT <- "#D9C0D9"
  RED <- "#FF0000"
  RED_DARK <- "#FF8080"
  RED_LIGHT <- "#FFB2B2"
  RED_UBERLIGHT <- "#FFECEC"
  RED_ULTRALIGHT <- "#FFD8D8"
  TEAl <- "#00FFC0"
  WHITE <- "#FFFFFF"
  YELLOW <- "#FFFF00"
  YELLOW_CA2 <- "#FFFF00"
  YELLOW_SUB <- "#FFC000"
      
  nNeurons = length(neuronLabels)
  nParcels = length(parcelLabels)
  
  if (plotLabel == "ARA_Old") {
    nParcellations = c(3, 5, 4, 4, 2)
    layerNames = list("SM", "SG", "H",
                      "SLM", "SR", "SL", "SP", "SO",
                      "SLM", "SR", "SP", "SO",
                      "SLM", "SR", "SP", "SO",
                      "SM", "SR")
  } else {
    nParcellations = c(3, 1, 1, 1, 1)
    layerNames = list("SM", "SG", "H",
                      " ",
                      " ",
                      " ",
                      " ")
  } # if plotLabel
  
  displayFontSize = 3
  if (nNeurons < 100) {
    displayFontSize = 6
  }

  shadingLineWidths = 1.0

  morphologyColors <- c(WHITE,  # 0
                        RED,    # 1
                        BLUE,   # 2
                        PURPLE) # 3
                        
  regionColor <- c(BROWN_DG,
                   BROWN_CA3,
                   YELLOW_CA2,
                   ORANGE_CA1,
                   YELLOW_SUB)
  
  hStart = nNeurons+11

  vStart = -2.5

  hTabShift = 0

  N = nParcels+1
    
  ## plot matrix ##
  
  morphologyHeatmap <- ggplot(data = morphologyMatrix)
  
  morphologyHeatmap

  morphologyInvasion <- data.matrix(morphologyMatrix)
  
  morphologyInvasionHeatmap <- heatmap(morphologyInvasion, Rowv = NA, Colv = NA, col = morphologyColors, asp = 1,
                                       add.expr = hatch_lines(morphologyInvasion, nNeurons, nParcels))
  
#  segments(0, 0, nParcels, nNeurons, col = BLUE, lwd = shadingLineWidths)
  
  for (i in 1:nNeurons) {
    for (j in 1:nParcels) {
      ### add horizontal white lines to neurite locations with axons
#      if ((morphologyInvasion[i,j] == 1) | (morphologyInvasion[i,j] == 3)) {
#        print("YO!")
#        segments(j, i+0.5, j+1, i+0.5, col = BLACK, lwd = shadingLineWidths)
#      }
      
      ### add vertical white lines to neurite locations with dendrites
#      if ((morphologyInvasion[i,j] == 2) | (morphologyInvasion[i,j] == 3)) {
#        print("OY!")
#        segments(j+0.5, i, j+0.5, i+1, col = BLACK, lwd = shadingLineWidths)
#      }
    }
  }
  
} # plot_morphology_matrix