function morphologyMatrix = preprocess_fuzzy_morphology_data(data,isPlotSupertypesOnly,isPlotSuperfamiliesOnly)

    load('./lib/constants.mat');
    
    N = size(data,1);
    
    morphologyMatrix = zeros(N,26);
    
    for i = 1:N
        if (data(i,S_DG_COL) == 1)
            subregion = DG;
        elseif (data(i,S_CA3_COL) == 1)
            subregion = CA3;
        elseif (data(i,S_CA2_COL) == 1)
            subregion = CA2;
        elseif (data(i,S_CA1_COL) == 1)
            subregion = CA1;
        elseif (data(i,S_SUB_COL) == 1)
            subregion = Sub;
        else % data(i,S_EC_COL) == 1
            subregion = EC;
        end
        
        EorI = INHIBITORY;
        if (data(i,E_OR_I_COL) == 1)
            EorI = EXCITATORY;
        end
        
        glutamatergicSubfamily = 0;
        if (EorI == EXCITATORY)
            if (data(i,GRANULE_COL) == 1)
                glutamatergicSubfamily = GRANULE;
            elseif (data(i,MOSSY_COL) == 1)
                glutamatergicSubfamily = MOSSY;
            elseif (data(i,PYRAMIDAL_COL) == 1)
                glutamatergicSubfamily = PYRAMIDAL;
            elseif (data(i,GIANT_COL) == 1)
                glutamatergicSubfamily = GIANT;
            else % data(i,CAJALRETZIUS_COL) == 1
                glutamatergicSubfamily = CAJALRETZIUS;
            end
        end
        
        if isPlotSupertypesOnly
            %%%%% Dentate Gyrus (DG)
            morphologyMatrix(i,DG_SMO) = merge_axons_and_dendrites(data(i,ST_A_DG_SMO_COL),data(i,ST_D_DG_SMO_COL));
            morphologyMatrix(i,DG_SMI) = merge_axons_and_dendrites(data(i,ST_A_DG_SMI_COL),data(i,ST_D_DG_SMI_COL));
            morphologyMatrix(i,DG_SG) = merge_axons_and_dendrites(data(i,ST_A_DG_SG_COL),data(i,ST_D_DG_SG_COL));
            morphologyMatrix(i,DG_H) = merge_axons_and_dendrites(data(i,ST_A_DG_H_COL),data(i,ST_D_DG_H_COL));
            
            %%%%% CA3
            morphologyMatrix(i,CA3_SLM) = merge_axons_and_dendrites(data(i,ST_A_CA3_SLM_COL),data(i,ST_D_CA3_SLM_COL));
            morphologyMatrix(i,CA3_SR) = merge_axons_and_dendrites(data(i,ST_A_CA3_SR_COL),data(i,ST_D_CA3_SR_COL));
            morphologyMatrix(i,CA3_SL) = merge_axons_and_dendrites(data(i,ST_A_CA3_SL_COL),data(i,ST_D_CA3_SL_COL));
            morphologyMatrix(i,CA3_SP) = merge_axons_and_dendrites(data(i,ST_A_CA3_SP_COL),data(i,ST_D_CA3_SP_COL));
            morphologyMatrix(i,CA3_SO) = merge_axons_and_dendrites(data(i,ST_A_CA3_SO_COL),data(i,ST_D_CA3_SO_COL));
            
            %%%%% CA2
            morphologyMatrix(i,CA2_SLM) = merge_axons_and_dendrites(data(i,ST_A_CA2_SLM_COL),data(i,ST_D_CA2_SLM_COL));
            morphologyMatrix(i,CA2_SR) = merge_axons_and_dendrites(data(i,ST_A_CA2_SR_COL),data(i,ST_D_CA2_SR_COL));
            morphologyMatrix(i,CA2_SP) = merge_axons_and_dendrites(data(i,ST_A_CA2_SP_COL),data(i,ST_D_CA2_SP_COL));
            morphologyMatrix(i,CA2_SO) = merge_axons_and_dendrites(data(i,ST_A_CA2_SO_COL),data(i,ST_D_CA2_SO_COL));
            
            %%%%% CA1
            morphologyMatrix(i,CA1_SLM) = merge_axons_and_dendrites(data(i,ST_A_CA1_SLM_COL),data(i,ST_D_CA1_SLM_COL));
            morphologyMatrix(i,CA1_SR) = merge_axons_and_dendrites(data(i,ST_A_CA1_SR_COL),data(i,ST_D_CA1_SR_COL));
            morphologyMatrix(i,CA1_SP) = merge_axons_and_dendrites(data(i,ST_A_CA1_SP_COL),data(i,ST_D_CA1_SP_COL));
            morphologyMatrix(i,CA1_SO) = merge_axons_and_dendrites(data(i,ST_A_CA1_SO_COL),data(i,ST_D_CA1_SO_COL));
            
            %%%%% Sub
            morphologyMatrix(i,SUB_SM) = merge_axons_and_dendrites(data(i,ST_A_SUB_SM_COL),data(i,ST_D_SUB_SM_COL));
            morphologyMatrix(i,SUB_SP) = merge_axons_and_dendrites(data(i,ST_A_SUB_SP_COL),data(i,ST_D_SUB_SP_COL));
            morphologyMatrix(i,SUB_PL) = merge_axons_and_dendrites(data(i,ST_A_SUB_PL_COL),data(i,ST_D_SUB_PL_COL));
            
            %%%%% EC
            morphologyMatrix(i,EC_LI) = merge_axons_and_dendrites(data(i,ST_A_EC_LI_COL),data(i,ST_D_EC_LI_COL));
            morphologyMatrix(i,EC_LII) = merge_axons_and_dendrites(data(i,ST_A_EC_LII_COL),data(i,ST_D_EC_LII_COL));
            morphologyMatrix(i,EC_LIII) = merge_axons_and_dendrites(data(i,ST_A_EC_LIII_COL),data(i,ST_D_EC_LIII_COL));
            morphologyMatrix(i,EC_LIV) = merge_axons_and_dendrites(data(i,ST_A_EC_LIV_COL),data(i,ST_D_EC_LIV_COL));
            morphologyMatrix(i,EC_LV) = merge_axons_and_dendrites(data(i,ST_A_EC_LV_COL),data(i,ST_D_EC_LV_COL));
            morphologyMatrix(i,EC_LVI) = merge_axons_and_dendrites(data(i,ST_A_EC_LVI_COL),data(i,ST_D_EC_LVI_COL));
        end % if isPlotSupertypesOnly
        
        if isPlotSuperfamiliesOnly
            %%%%% Dentate Gyrus (DG)
            morphologyMatrix(i,DG_SMO) = merge_axons_and_dendrites(data(i,SF_A_DG_SMO_COL),data(i,SF_D_DG_SMO_COL));
            morphologyMatrix(i,DG_SMI) = merge_axons_and_dendrites(data(i,SF_A_DG_SMI_COL),data(i,SF_D_DG_SMI_COL));
            morphologyMatrix(i,DG_SG) = merge_axons_and_dendrites(data(i,SF_A_DG_SG_COL),data(i,SF_D_DG_SG_COL));
            morphologyMatrix(i,DG_H) = merge_axons_and_dendrites(data(i,SF_A_DG_H_COL),data(i,SF_D_DG_H_COL));
            
            %%%%% CA3
            morphologyMatrix(i,CA3_SLM) = merge_axons_and_dendrites(data(i,SF_A_CA3_SLM_COL),data(i,SF_D_CA3_SLM_COL));
            morphologyMatrix(i,CA3_SR) = merge_axons_and_dendrites(data(i,SF_A_CA3_SR_COL),data(i,SF_D_CA3_SR_COL));
            morphologyMatrix(i,CA3_SL) = merge_axons_and_dendrites(data(i,SF_A_CA3_SL_COL),data(i,SF_D_CA3_SL_COL));
            morphologyMatrix(i,CA3_SP) = merge_axons_and_dendrites(data(i,SF_A_CA3_SP_COL),data(i,SF_D_CA3_SP_COL));
            morphologyMatrix(i,CA3_SO) = merge_axons_and_dendrites(data(i,SF_A_CA3_SO_COL),data(i,SF_D_CA3_SO_COL));
            
            %%%%% CA2
            morphologyMatrix(i,CA2_SLM) = merge_axons_and_dendrites(data(i,SF_A_CA2_SLM_COL),data(i,SF_D_CA2_SLM_COL));
            morphologyMatrix(i,CA2_SR) = merge_axons_and_dendrites(data(i,SF_A_CA2_SR_COL),data(i,SF_D_CA2_SR_COL));
            morphologyMatrix(i,CA2_SP) = merge_axons_and_dendrites(data(i,SF_A_CA2_SP_COL),data(i,SF_D_CA2_SP_COL));
            morphologyMatrix(i,CA2_SO) = merge_axons_and_dendrites(data(i,SF_A_CA2_SO_COL),data(i,SF_D_CA2_SO_COL));
            
            %%%%% CA1
            morphologyMatrix(i,CA1_SLM) = merge_axons_and_dendrites(data(i,SF_A_CA1_SLM_COL),data(i,SF_D_CA1_SLM_COL));
            morphologyMatrix(i,CA1_SR) = merge_axons_and_dendrites(data(i,SF_A_CA1_SR_COL),data(i,SF_D_CA1_SR_COL));
            morphologyMatrix(i,CA1_SP) = merge_axons_and_dendrites(data(i,SF_A_CA1_SP_COL),data(i,SF_D_CA1_SP_COL));
            morphologyMatrix(i,CA1_SO) = merge_axons_and_dendrites(data(i,SF_A_CA1_SO_COL),data(i,SF_D_CA1_SO_COL));
            
            %%%%% Sub
            morphologyMatrix(i,SUB_SM) = merge_axons_and_dendrites(data(i,SF_A_SUB_SM_COL),data(i,SF_D_SUB_SM_COL));
            morphologyMatrix(i,SUB_SP) = merge_axons_and_dendrites(data(i,SF_A_SUB_SP_COL),data(i,SF_D_SUB_SP_COL));
            morphologyMatrix(i,SUB_PL) = merge_axons_and_dendrites(data(i,SF_A_SUB_PL_COL),data(i,SF_D_SUB_PL_COL));
            
            %%%%% EC
            morphologyMatrix(i,EC_LI) = merge_axons_and_dendrites(data(i,SF_A_EC_LI_COL),data(i,SF_D_EC_LI_COL));
            morphologyMatrix(i,EC_LII) = merge_axons_and_dendrites(data(i,SF_A_EC_LII_COL),data(i,SF_D_EC_LII_COL));
            morphologyMatrix(i,EC_LIII) = merge_axons_and_dendrites(data(i,SF_A_EC_LIII_COL),data(i,SF_D_EC_LIII_COL));
            morphologyMatrix(i,EC_LIV) = merge_axons_and_dendrites(data(i,SF_A_EC_LIV_COL),data(i,SF_D_EC_LIV_COL));
            morphologyMatrix(i,EC_LV) = merge_axons_and_dendrites(data(i,SF_A_EC_LV_COL),data(i,SF_D_EC_LV_COL));
            morphologyMatrix(i,EC_LVI) = merge_axons_and_dendrites(data(i,SF_A_EC_LVI_COL),data(i,SF_D_EC_LVI_COL));
        end % if isPlotSuperfamiliesOnly
                
    end % i
        
end % preprocess_fuzzy_morphology_data()