import datetime

def clr():
	print("\033c") # clear screen
	return
	

def time_stamp():
    today = datetime.datetime.now()    
    timeStampStr = "%4d%02d%02d%02d%02d" % (today.year, today.month, today.day, today.hour, today.minute)
    return timeStampStr

def size2x2(twoByTwoMatrix):
	nRows = len(twoByTwoMatrix)
	nColumns = len(twoByTwoMatrix[0])
	return(nRows, nColumns)
	
	
def pause():
    print
    programPause = raw_input("Press the <ENTER> key to continue...")
    print
    
    
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
    
    
def get_col(data,n):
    return [x[n] for x in data]