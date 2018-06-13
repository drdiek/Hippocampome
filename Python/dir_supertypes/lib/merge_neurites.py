def merge_axons_and_dendrites(A,D):

    if ((A == 2) and (D == 2)):      # PURPLE
        return(15)
    elif ((A == 2) and (D == 1)):    # (RED+BLUE_LIGHT)/2
        return(14)
    elif ((A == 2) and (D == 0)):    # (RED+BLUE_ULTRALIGHT)/2
        return(13)
    elif ((A == 2) and (D == -1)):   # RED
        return(12)
    elif ((A == 1) and (D == 2)):    # (RED_LIGHT+BLUE)/2
        return(11)
    elif ((A == 1) and (D == 1)):    # PURPLE_LIGHT
        return(10)
    elif ((A == 1) and (D == 0)):    # (RED_LIGHT+BLUE_ULTRALIGHT)/2
        return(9)
    elif ((A == 1) and (D == -1)):   # RED_LIGHT
        return(8)
    elif ((A == 0) and (D == 2)):    # (RED_ULTRALIGHT+BLUE)/2
        return(7)
    elif ((A == 0) and (D == 1)):    # (RED_ULTRALIGHT+BLUE_LIGHT)/2
        return(6)
    elif ((A == 0) and (D == 0)):    # PURPLE_ULTRALIGHT
        return(5)
    elif ((A == 0) and (D == -1)):   # RED_ULTRALIGHT
        return(4)
    elif ((A == -1) and (D == 2)):   # BLUE
        return(3)
    elif ((A == -1) and (D == 1)):   # BLUE_LIGHT
        return(2)
    elif ((A == -1) and (D == 0)):   # BLUE_ULTRALIGHT
        return(1)
    else # ((A == -1) and (D == -1)) # WHITE
        return(0)