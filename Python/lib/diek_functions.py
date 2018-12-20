def clr():
	print("\033c"); # clear screen	
	return
	

def time_stamp():
    import datetime

    today = datetime.datetime.now()
    timeStampStr = ['{}'.format(today.year), \
                    '{:0>2}'.format(today.month), \
                    '{:0>2}'.format(today.day), \
                    '{:0>2}'.format(today.hour), \
                    '{:0>2}'.format(today.minute)]
    return ''.join(timeStampStr)


def size2x2(twoByTwoMatrix):
	numRows = len(twoByTwoMatrix)
	numCols = len(twoByTwoMatrix[0])
	return(numRows, numCols)
	
	
def pause():
    print ''
    programPause = raw_input("Press the <ENTER> key to continue...")
    
    
def all_indices(value, qlist):
    indices = []
    idx = -1
    while True:
        try:
            idx = qlist.index(value, idx+1)
            indices.append(idx)
        except ValueError:
            break
    return indices
    
