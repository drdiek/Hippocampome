import matplotlib.colors as mcolors
import matplotlib.pyplot as plt
    
#class RGBcolor():
#    def __init__(self, red, green, blue):
#        self.red   = float(red)   / 255.0 # R value: 0-255
#        self.green = float(green) / 255.0 # G value: 0-255
#        self.blue  = float(blue)  / 255.0 # B value: 0-255
#        
#    def __call__(self):
#        return [self.red, self.green, self.blue]


class HCcolors:
    def RGBcolor(red, green, blue):
        return [float(red)/255.0, float(green)/255.0, float(blue)/255.0]
#    RGBcolor = lambda red, green, blue: [float(red)/255.0, float(green)/255.0, float(blue)/255.0]

    BLACK             = RGBcolor(   0,   0,   0 )
    BLUE              = RGBcolor(   0,   0, 255 )
    BLUE_DARK         = RGBcolor(   0,   0, 128 )
    BLUE_MEDIUM       = RGBcolor(   0,   0, 192 )
    BLUE_LIGHT        = RGBcolor( 143, 172, 255 )
    BLUE_SKY          = RGBcolor(   0, 204, 255 )
    BLUE_UBERLIGHT    = RGBcolor( 227, 233, 255 )
    BLUE_ULTRALIGHT   = RGBcolor( 199, 214, 255 )
    BROWN             = RGBcolor( 153, 102,  51 )
    BROWN_DG          = RGBcolor(  91,  45,  10 )
    BROWN_CA3         = RGBcolor( 165, 131, 107 )
    GRAY              = RGBcolor( 128, 128, 128 )
    GRAY_DARK         = RGBcolor(  64,  64,  64 )
    GRAY_MEDIUM       = RGBcolor(  96,  96,  96 )
    GRAY_LIGHT        = RGBcolor( 192, 192, 192 )
    GRAY_ULTRALIGHT   = RGBcolor( 230, 230, 230 )
    GREEN             = RGBcolor(   0, 128,   0 )
    GREEN_DARK        = RGBcolor(   0,  64,   0 )
    GREEN_MEDIUM      = RGBcolor(   0, 192,   0 )
    GREEN_BRIGHT      = RGBcolor(   0, 255,   0 )
    GREEN_EC          = RGBcolor( 106, 149,  49 )
    GREEN_LEC         = RGBcolor(  90, 111,  47 )
    GREEN_MEC         = RGBcolor( 122, 187,  51 )
    ORANGE            = RGBcolor( 228, 108,  10 )
    ORANGE_LIGHT      = RGBcolor( 247, 156,  21 )
    ORANGE_CA1        = RGBcolor( 217, 104,  13 )
    PURPLE            = RGBcolor( 128,   0, 128 )
    PURPLE_LIGHT      = RGBcolor( 178, 128, 178 )
    PURPLE_UBERLIGHT  = RGBcolor( 236, 224, 236 )
    PURPLE_ULTRALIGHT = RGBcolor( 217, 192, 217 )
    RED               = RGBcolor( 255,   0,   0 )
    RED_LIGHT         = RGBcolor( 255, 178, 178 )
    RED_UBERLIGHT     = RGBcolor( 255, 236, 236 )
    RED_ULTRALIGHT    = RGBcolor( 255, 216, 216 )
    TEAL              = RGBcolor(   0, 255, 192 )
    WHITE             = RGBcolor( 255, 255, 255 )
    YELLOW            = RGBcolor( 255, 255,   0 )
    YELLOW_CA2        = RGBcolor( 255, 255,   0 )
    YELLOW_Sub        = RGBcolor( 255, 192,   0 )

def make_color_map(colorsToMap):
    # Example:
    # WHITE ->> 4 colors ->> colorDictionary["red"] = [0.0, None, 1.0], <<- [0/4, r1 from None,   r2 from WHITE]
    # RED                                             [0.25, 1.0, 1.0], <<- [1/4, r1 from WHITE,  r2 from RED]
    # BLUE                                            [0.5, 1.0, 0.0],  <<- [1/2, r1 from RED,    r2 from BLUE]
    # PURPLE                                          [0.75, 0.0, 0.5], <<- [3/4, r1 from BLUE,   r2 from PURPLE]
    #                                                 [1.0, 0.5, None]  <<- [4/4, r1 from Purple, r2 from None]

    nColorsToMap = len(colorsToMap)                   # e.g. 4 colorsToMap

    colors = [[None for j in range(3)] for i in range(nColorsToMap+2)]
    # e.g. colors = [[None, None, None],
    #                [None, None, None],
    #                [None, None, None],
    #                [None, None, None],
    #                [None, None, None],
    #                [None, None, None]]

    nColors = len(colors)                             # e.g. 6 colors

    for i in range(nColorsToMap):

        colors[i+1] = colorsToMap[i]                  # e.g. colors = [None, None, None],
                                                      #               [ 1.0,  1.0,  1.0], WHITE
                                                      #               [ 1.0,  0.0,  0.0], RED
                                                      #               [ 0.0,  0.0,  1.0], BLUE
                                                      #               [ 0.5,  0.0,  0.5], PURPLE
                                                      #               [None, None, None]
    
    colorDictionary = {"red": [],
                       "green": [],
                       "blue": []}

    for i in range(nColors-1):
    
        r1, g1, b1 = colors[i]
        r2, g2, b2 = colors[i + 1]

        fraction = float(i) / float(nColorsToMap)

        colorDictionary["red"].append([fraction, r1, r2])
        colorDictionary["green"].append([fraction, g1, g2])
        colorDictionary["blue"].append([fraction, b1, b2])
    
    return mcolors.LinearSegmentedColormap("CustomMap", colorDictionary)


def make_colormap(seq):
    """Return a LinearSegmentedColormap
    seq: a sequence of floats and RGB-tuples. The floats should be increasing
    and in the interval (0,1).
    """
    
    seq = [(None,) * 3, 0.0] + list(seq) + [1.0, (None,) * 3]
    cdict = {"red": [], "green": [], "blue": []}
    for i, item in enumerate(seq):
        if isinstance(item, float):
            r1, g1, b1 = seq[i - 1]
            r2, g2, b2 = seq[i + 1]
            cdict["red"].append([item, r1, r2])
            cdict["green"].append([item, g1, g2])
            cdict["blue"].append([item, b1, b2])
    return mcolors.LinearSegmentedColormap("CustomMap", cdict)


def plot_dendrite_lines(neurites):

    nRows, nCols = size2x2(neurites)
    
    if nRows > 50:
        lineWidth = 0.5
    elif nRows > 25:
        lineWidth = 1.0
    else:
        lineWidth = 2.0
    
    for row in range(nRows):
        for col in range(nCols):
            if (neurites[row,col] == 2.0) | (neurites[row,col] == 3.0):
                plt.plot([col+0.5, col+0.5], [row+0.1, row+0.9], "w", linewidth=lineWidth)

                
def plot_axon_lines(neurites):

    nRows, nCols = size2x2(neurites)
    
    if nRows > 50:
        lineWidth = 0.5
    elif nRows > 25:
        lineWidth = 1.0
    else:
        lineWidth = 2.0
    
    for row in range(nRows):
        for col in range(nCols):
            if (neurites[row,col] == 1.0) | (neurites[row,col] == 3.0):
                plt.plot([col+0.1, col+0.9], [row+0.5, row+0.5], "w", linewidth=lineWidth)
              
            
def plot_hatch_lines(matrix):

    nRows, nCols = size2x2(matrix)
    
    if nRows > 50:
        lineWidth = 0.5
    elif nRows > 25:
        lineWidth = 1.0
    else:
        lineWidth = 2.0
    
    for row in range(nRows+1):
        for col in range(nCols+1):
            plt.plot([col, col], [0, nRows], "k", linewidth=lineWidth)
            plt.plot([0, nCols], [row, row], "k", linewidth=lineWidth)
