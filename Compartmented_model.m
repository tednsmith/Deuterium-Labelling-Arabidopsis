clear
x = linspace(0,1);
yout = zeros(100,7);
labels = ["Fractional concentration  of cytosolic G6P =",
    "Fractional concentration  of cytosolic NADPH =",
    "Fractional NADPH production in the cytosol =",
    "Fraction of cytosolic NADPH production from oxPPP =",
    "Fraction of plastidic NADPH production from oxPPP =",
    "Fractional labelling of cytosolic G6P =",
    "Fractional labelling of plastidic G6P ="];
labels_in = strings([1,7]);

%Define inputs for variable parameters. Inputs are in the order of "labels"
input1 = [0.85 0.5 0.18 1.0 0.9 0.5 0.4];

%Add input values to figure legend 
for n = 1:length(labels)
    labels_in(n) = sprintf('%s %g', labels(n), input1(n))
end

%For each variable vary it between 0 and 1 whilst all other vairables are
%fixed
for ii = 1:length(input1)
    
    input = input1;

%caluclate the deviation from the accurate value for each set of variables 
    for i = 1:length(x)
       input(ii) = x(i);
       y(i) = C_Mod(input);
    end

yout(:,ii) = y;
    
end

plot(x,yout)
legend(labels_in)
title('Effect of compartmentaion')
xlabel('Fraction')
ylabel('Discrepancy between measured and accurate value (%)')

function dev = C_Mod(input)
      
      
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



