import math
import sympy
from add_comma_separation import add_comma_separation

for n in range(1,27):
    
    nPatternsTotal = math.pow(4,n)

    nPatternsAllZeros = 1

    nPatternsJustDendrites = 0

    for k in range(1,n+1):

        nPatternsJustDendrites = nPatternsJustDendrites + int(sympy.binomial(n, k))
        
    nPatternsJustAxons = nPatternsJustDendrites

    nPatternsNet = nPatternsTotal - nPatternsJustDendrites - nPatternsJustAxons - nPatternsAllZeros

    nPatternsNetStr = add_comma_separation(nPatternsNet)

    print "%2d parcels nets %s patterns." % (n, nPatternsNetStr)


