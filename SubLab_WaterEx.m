oxPPP = 0.403 %oxPPP contribution to NADPH production 
subb = 0.432 %substrate labelling measured from 100% [1-2H]glucose feeding experiment
ex = 0.8 %water exhcange fraction to be fixed when substrate labelling is varied 
KIE = 1.8; %deuterium kinetic isotope effect for G6PDH
NADPH = zeros(10,4); %NADPH is output of redox hydride labelling 

%vary substrate labelling, fix water exchange, KIE is applied
for n = 1:11
    sub = linspace(0,1,11)
    NADPH(n,1) = 100*(SA(oxPPP, sub(n), ex, KIE))
end

%vary substrate labelling, fix water exchange, no KIE
for n = 1:11
    sub = linspace(0,1,11)
    NADPH(n,2) = 100*(SA(oxPPP, sub(n), ex, 1))
end

%vary water exchange, fix substrate labelling, KIE is applied
for n = 1:11
    sub = subb
    ex = linspace(0,1,11)
    NADPH(n,3) = 100*(SA(oxPPP, sub, ex(n), KIE))
end

%vary water exchange, fix substrate labelling, no KIE
for n = 1:11
    sub = subb
    ex = linspace(0,1,11)
    NADPH(n,4) = 100*(SA(oxPPP, sub, ex(n), 1))
end
 
plot(linspace(0,100,11),NADPH)
legend(["Substrate labelling KIE=1.8","Substrate Lablelling KIE = 1.0","Water exchange KIE = 1.8"," Water exchange KIE = 1.0"])
xlabel('Water exchange or substrate labelling (%)')
ylabel('NADPH redox active hydride labellng (%)')

function [y] = SA(oxPPP, sub, ex, KIE)

 y = oxPPP*(1-ex)*((KIE+(sub*(1-KIE)))^-1)*sub*(2^-1);
 
end