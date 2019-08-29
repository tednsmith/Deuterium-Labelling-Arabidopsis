%% Fractional Labelling of NADPH redox active site

% The fractional NADPH redox active site labelling(x) was measured from the
% Observed NADPH and NADP+ labeling patterns from the same sample. 
%nadp and nadph are vectors of normalised MIDs with each sample in a new
%row and each column representing M+n isotopologues 

a = nadp
b = nadph

x = zeros(1, size(b, 1));
resnorm = zeros(1, size(b, 1));

for i = 1:size(b,1)
    
% Define observations for individual sample  
Mnadp_obs = [a(i,1) a(i,2) a(i,3) 0]'; %note the extra 0 to account for vector rotation 
Mnadph_obs = [b(i,1) b(i,2) b(i,3)  ]';

%Solve for x in a least squares sense 
%Mnadph_obs(n) = Mnadp_obs(n)*(1-x) + Mnadp_obs(n-1)*(x)

x0 = 0.5;
[x(i), resnorm(i)] = lsqcurvefit(@fun3,x0,Mnadp_obs,Mnadph_obs);
ModelNADPH = fun3(x(i),Mnadp_obs);
nadpbar = Mnadp_obs(1:3); 

figure(i)
bar([nadpbar, Mnadph_obs, ModelNADPH])
legend('NADP+ obs', 'NADPH obs', 'Model NADPH')

end 

%Output each sample in a row with NADPH redox hydride labelling in first
%column and residual from fit in second column 
result = [x; resnorm;]';

   function Mnadph = fun3(x,Mnadp_obs)   
   
    A = [Mnadp_obs];
    B = [circshift(A,[1 1])];

    Mnadph = (A*[1-x] + B*[x])/(1-(A(3)*[x]));
    Mnadph(4) = '';
    sum(Mnadph);
    end