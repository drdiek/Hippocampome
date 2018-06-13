def add_comma_separation(N):

    nStr = str(int(N))

    lenStr = len(nStr)

    if lenStr > 3:

            counter = 0

            for i in range(lenStr,0,-1):

                if counter == 3:

                   parts = [nStr[:i], nStr[i:]]
	           nStr = ','.join(parts)
                   counter = 1

                else:

                    counter = counter + 1

    return(nStr)
