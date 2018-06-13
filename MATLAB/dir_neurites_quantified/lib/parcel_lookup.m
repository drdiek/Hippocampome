function parcelNo = parcel_lookup(parcelStr)

    parcels( 1) = {'DG:SMo'};
    parcels( 2) = {'DG:SMi'};
    parcels( 3) = {'DG:SG'};
    parcels( 4) = {'DG:H'};
    parcels( 5) = {'CA3:SLM'};
    parcels( 6) = {'CA3:SR'};
    parcels( 7) = {'CA3:SL'};
    parcels( 8) = {'CA3:SP'};
    parcels( 9) = {'CA3:SO'};
    parcels(10) = {'CA2:SLM'};
    parcels(11) = {'CA2:SR'};
    parcels(12) = {'CA2:SP'};
    parcels(13) = {'CA2:SO'};
    parcels(14) = {'CA1:SLM'};
    parcels(15) = {'CA1:SR'};
    parcels(16) = {'CA1:SP'};
    parcels(17) = {'CA1:SO'};
    parcels(18) = {'Sub:SM'};
    parcels(19) = {'Sub:SP'};
    parcels(20) = {'Sub:PL'};
    parcels(21) = {'EC:I'};
    parcels(22) = {'EC:II'};
    parcels(23) = {'EC:III'};
    parcels(24) = {'EC:IV'};
    parcels(25) = {'EC:V'};
    parcels(26) = {'EC:VI'};
    
    for i = 1:length(parcels)
        if strcmp(parcels(i),parcelStr)
            parcelNo = i;
        end
    end

end % parcel_lookup()