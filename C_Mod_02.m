
%[0.7 0.2 0.2 0.1 0.5 0.3 0.2]

function dev = C_Mod_02(input)
      
      
    %%Pool sizes
    
    G6P_c = input(1);   %Proportion of G6P pool in cytosol 
    G6P_p = 1 - G6P_c;  %Proportion of G6P pool in plastid 
    
    NADPH_c = input(2);  %Proportion of NADPH pool in cytosol
    NADPH_p = 1 - NADPH_c;  %Proportion of NADPH pool in plastid
 
    %%Fluxes
        
    cyt_t = input(3);   %Proportion of total NADPH production flux in cytosol 
    pls_t = 1- cyt_t;   %Proportion of total NADPH production flux in plastid 
    
    oxppp_c = input(4) * cyt_t;  %Proportion of total NADPH production flux from cytosolic oxPPP = fraction of cytosolic NADPH production from oxPPP * fraction of total NADPH production flux in cytosol
    oxppp_p = input(5) * pls_t;  %Proportion of total NADPH production flux from plastidic oxPPP = fraction of plastidic NADPH production from oxPPP * fraction of total NADPH production flux in plastid
  
    %%Fractional Labelling
    
    L_G6P_c = input(6);  %Fractional labelling of cytosolic G6P
    L_G6P_p = input(7);  %Fractional labelling of plastidic G6P
    L_G6P_t = (L_G6P_c * G6P_c)+(L_G6P_p * G6P_p)   %Apparent fractional labelling of G6P from whole cell extraction 
    
    L_NADPH_c = (oxppp_c/cyt_t) * L_G6P_c;  %Fractional labelling of cytosolic NADPH = fraction of cytosolic NADPH production from oxPPP * Fractional labelling of cytosolic G6P
    L_NADPH_p = (oxppp_p/pls_t) * L_G6P_p;  %Fractional labelling of plastidic NADPH = fraction of plastidic NADPH production from oxPPP * Fractional labelling of plastidic G6P
    L_NADPH_t = ((L_NADPH_c * NADPH_c) +(L_NADPH_p * NADPH_p) ) %Apparent fractional labelling of NADPH from whole cell extraction
    
    %%Contribution of oxPPP to total NADPH production
    
    C_oxppp1 = oxppp_c  + oxppp_p  %True contribution of oxPPP to total cellular NADPH production from defined fluxes 
    C_oxppp2 = L_NADPH_t/ L_G6P_t %Apparent contribution of oxPPP to total cellular NADPH production from whole cell extract
    
    dev = (C_oxppp2 - C_oxppp1)*100;  %absolute discrepancy between true and apparent contribution (% points)
end


