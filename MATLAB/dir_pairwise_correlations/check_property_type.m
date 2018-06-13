function propertyType = check_property_type(i)

    if ((i == 1) || (i == 2)) % Glutamateric / Projecting

        propertyType = 1;

    elseif ((3 <= i) && (i <= 104)) % morphology

        propertyType = 2;

    elseif ((105 <= i) && (i <= 139)) % marker

        propertyType = 3;

    else % electrophysiology

        propertyType = 4;

    end

end