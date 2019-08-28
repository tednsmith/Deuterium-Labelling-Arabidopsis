
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

% [0.2 0.2 0.2 0.9 0.2 0.5 0.4]
% [0.85 0.5 0.18 1 0.9 0.4 0.4]
input1 = [0.85 0.5 0.18 0.9 0.9 0.5 0.5];

for n = 1:length(labels)
    labels_in(n) = sprintf('%s %g', labels(n), input1(n))
end


for ii = 1:7
    
    input = input1;


    for i = 1:length(x)
    %[0.7 0.2 0.2 0.1 0.5 0.3 0.2]
     input(ii) = x(i);
    
     y(i) = C_Mod_02(input);
    
    end

yout(:,ii) = y;
    
end

plot(x,yout)
legend(labels_in)
title('Effect of compartmentaion')
xlabel('Fraction')
ylabel('Discrepancy between measured and true value (%)')
