function parcels = assign_parcel_values(X, Y, Z, ANO)

    N = length(X)
    pause

    for i = 1:N
        [round(X(i)) round(Y(i)) round(Z(i))]
        
        % adjust for 25 um slices to align coordinate systems
        parcels(i) = ANO(round(X(i)/25.0), round(Y(i)/25.0), round(Z(i)/25.0));
%        parcels(i) = interp3(ANO, X(i), Y(i), Z(i)); 
    end
    
end % assign_parcel_values()