def parcel_lookup(parcel):
    parcels = ('DG:SMo', \
               'DG:SMi', \
               'DG:SG', \
               'DG:H', \
               'CA3:SLM', \
               'CA3:SR', \
               'CA3:SL', \
               'CA3:SP', \
               'CA3:SO', \
               'CA2:SLM', \
               'CA2:SR', \
               'CA2:SP', \
               'CA2:SO', \
               'CA1:SLM', \
               'CA1:SR', \
               'CA1:SP', \
               'CA1:SO', \
               'Sub:SM', \
               'Sub:SP', \
               'Sub:PL', \
               'EC:I', \
               'EC:II', \
               'EC:III', \
               'EC:IV', \
               'EC:V', \
               'EC:VI')
    for i in range(len(parcels)):
        if parcels[i] == parcel:
            parcelNo = i
    return(parcelNo)