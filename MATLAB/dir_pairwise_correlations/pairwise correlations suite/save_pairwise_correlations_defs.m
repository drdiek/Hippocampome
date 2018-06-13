function save_pairwise_correlations_defs()

nParcels = 26;
nMarkers = 36;
nEphys = 7;

AXONS = 1:nParcels;
DENDRITES = AXONS(end)+[1:nParcels];
SOMATA = DENDRITES(end)+[1:nParcels];

MARKERS = SOMATA(end)+[1:nMarkers];

EPHYS = MARKERS(end)+[1:nEphys];

ALLPROPERTIES = [AXONS DENDRITES SOMATA MARKERS EPHYS];

nProperties = ALLPROPERTIES(end);

save pairwise_correlations_defs.mat *

end