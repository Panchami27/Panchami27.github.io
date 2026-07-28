clc;
clear all;

%Program to design heat exchanger network using temperature interval method
%Data from Example 10.2 (Warren D. Seider, J. D. Seader, Daniel R. Lewin, Product and Process Design Principles: Synthesis, Analysis, and Evaluation, 2nd Edition, Wiley)
%Also tested for data from Example 10.7 from the same reference

deltaTmin = 10; %input deltaTmin between hot and cold streams
Thot1 = [160 260]; %Input hot stream 1 temperatures, degreeF
Thot2 = [130 250]; %Input hot stream 2 temperatures, degreeF

Tcold1 = [120 235]; %Input cold stream 1 temperatures, degreeF
Tcold2 = [180 240]; %Input cold stream 2 temperatures, degreeF

mcphot1 = 30000; %Input hot stream 1 heat capacity rate, BTU/hr.degreeF
mcphot2 = 15000; %Input hot stream 2 heat capacity rate, BTU/hr.degreeF

mcpcold1 = 20000; %Input cold stream 1 heat capacity rate, BTU/hr.degreeF
mcpcold2 = 40000; %Input cold stream 2 heat capacity rate, BTU/hr.degreeF

%To plot Hohmann/Lochart Composite Curves (HCC)
HCCTall = [Thot1 Thot2]; %combine all hot stream temperatures into one main vector
HCCTall = sort(HCCTall, 'descend'); %arrange modified temperatures in decreasing order

%remove any components in modified temperature vector that are same
HCCTall_m = unique(HCCTall, 'stable');
W = length(HCCTall_m);

Qhot1 = mcphot1*(Thot1(2)-Thot1(1));
Qhot2 = mcphot2*(Thot2(2)-Thot2(1));
Qhot = Qhot1 + Qhot2;

%divide temperatures into intervals and find which stream is in which
%interval and calculate Qint of each temperature interval

for f = 2:W %interval from HCCTall_m(f-1) to HCCTall_m(f)
    T_high1 = HCCTall_m(f-1);
    T_low1 = HCCTall_m(f);
    
    H1_1 = isbetween(T_high1, Thot1(1), Thot1(2)) && isbetween(T_low1, Thot1(1), Thot1(2));
    H2_1 = isbetween(T_high1, Thot2(1), Thot2(2)) && isbetween(T_low1, Thot2(1), Thot2(2));
    
    mchot = 0;

    if H1_1, mchot = mchot + mcphot1; end
    if H2_1, mchot = mchot + mcphot2; end
    
    dTh = T_high1-T_low1;
    Qint1(f-1) = (mchot)*dTh;
end

for f = 2:W %calculate cumulative heat load of each interval
    Qcum(1) = Qhot;
    Qcum(f) = Qcum(f-1) - Qint1(f-1);
end

HCCTallc = [Tcold1 Tcold2]; %combine all cold stream temperatures into one main vector
HCCTallc = sort(HCCTallc, 'descend'); %arrange modified temperatures in decreasing order

%remove any components in modified temperature vector that are same
HCCTall_mc = unique(HCCTallc, 'stable');
E = length(HCCTall_mc);

Qcold1 = mcpcold1*(Tcold1(2)-Tcold1(1));
Qcold2 = mcpcold2*(Tcold2(2)-Tcold2(1));
Qcold = Qcold1 + Qcold2;

%divide temperatures into intervals and find which stream is in which
%interval and calculate Qint of each temperature interval

for g = 2:E %interval from HCCTall_mc(f-1) to HCCTall_mc(f)
    T_high2 = HCCTall_mc(g-1);
    T_low2 = HCCTall_mc(g);
    
    H1_2 = isbetween(T_high2, Tcold1(1), Tcold1(2)) && isbetween(T_low2, Tcold1(1), Tcold1(2));
    H2_2 = isbetween(T_high2, Tcold2(1), Tcold2(2)) && isbetween(T_low2, Tcold2(1), Tcold2(2));
    
    mccold = 0;

    if H1_2, mccold = mccold + mcpcold1; end
    if H2_2, mccold = mccold + mcpcold2; end
    
    dTh = T_high2-T_low2;
    Qint2(g-1) = (mccold)*dTh;
end

for g = 2:E %calculate cumulative heat load of each interval
    Qcumm(1) = Qcold;
    Qcumm(g) = Qcumm(g-1) - Qint2(g-1);
end

figure (2)
plot(Qcum, HCCTall_m, '-r')
hold on
plot(Qcumm, HCCTall_mc, '-g')
grid on
xlabel('Heat load [BTU/hr]')
ylabel('Temperature [°F]')
legend('Hot Composite Curve', 'Cold Composite Curve', 'Location', 'northwest')
title('Hohmann/ Lochart Composite Curves HCC')
hold off

%check if hot and cold composite curves intersect or approach each other
%shift cold composite curve by deltaTmin
