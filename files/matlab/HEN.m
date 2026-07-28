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

Thot1m = Thot1 - [deltaTmin deltaTmin]; %deltaTmin subtracted from hot stream temperatures to obtain adjusted temperatures
Thot2m = Thot2 - [deltaTmin deltaTmin];

Tall = [Thot1m Thot2m Tcold1 Tcold2]; %combine all stream temperatures into one main vector

Tallm = sort(Tall, 'descend'); %arrange modified temperatures in decreasing order

%remove any components in modified temperature vector that are same
Tall_m = unique(Tallm, 'stable');
N = length(Tall_m);

%divide temperatures into intervals and find which stream is in which
%interval and calculate enthalpy difference of each temperature interval

for i = 2:N %interval from Tall_m(i-1) to Tall_m(i)
    T_high = Tall_m(i-1);
    T_low = Tall_m(i);
    
    H1 = isbetween(T_high, Thot1m(1), Thot1m(2)) && isbetween(T_low, Thot1m(1), Thot1m(2));
    H2 = isbetween(T_high, Thot2m(1), Thot2m(2)) && isbetween(T_low, Thot2m(1), Thot2m(2));
    C1 = isbetween(T_high, Tcold1(1), Tcold1(2)) && isbetween(T_low, Tcold1(1), Tcold1(2));
    C2 = isbetween(T_high, Tcold2(1), Tcold2(2)) && isbetween(T_low, Tcold2(1), Tcold2(2));
    
    mcphot = 0;
    mcpcold= 0;

    if H1, mcphot = mcphot + mcphot1; end
    if H2, mcphot = mcphot + mcphot2; end
    if C1, mcpcold = mcpcold + mcpcold1; end
    if C2, mcpcold = mcpcold + mcpcold2; end
    
    dT = T_high-T_low;
    enthal(i-1) = (mcphot-mcpcold)*dT;
end


O = length(enthal);
%energy flow calculation - find residual energy of each temp. interval by
%doing initial pass
R = zeros(1, O);
Qsteam = 0;
R(1) = Qsteam + enthal(1);

for l = 2:O
    R(l) = R(l-1) + enthal(l);
end

Qcw = R(end);

for l = 1:O
    if (R(l) == 0)
        disp(['Qsteam = ', num2str(Qsteam), 'BTU/hr']);
        disp(['Qcw = ', num2str(Qcw), 'BTU/hr']);
        Coldpin = Tall_m(l);
        disp(['Cold pinch temp =', num2str(Coldpin), 'degreeF']);
        Hotpin = Tall_m(l) + deltaTmin;
        disp(['Hot pinch temp =', num2str(Hotpin), 'degreeF']);
        
        figure (1) %to plot Grand Composite Curve (GCC)
        plot(R, Tall_m)
        grid on
        xlabel('Enthalpy [BTU/hr]')
        ylabel('Adjusted Temperature [°F]')
        text(0.02,0.98,'Hot Utility','Units','normalized');
        text(0.02,0.02,'Cold Utility','Units','normalized');
    else
        for x = 1:O
        D = -1*min(R); %find maximum negative value in R
        Qsteam = D;
        S(1) = Qsteam;
        S(x+1) = R(x) + D;
        end
    end
end

Qcw = S(end);

for m = 1:O
    if (S(m) == 0)
        disp(['Qsteam = ', num2str(Qsteam)]);
        disp(['Qcw = ', num2str(Qcw)]);
        Coldpin = Tall_m(m);
        disp(['Cold pinch temp = ', num2str(Coldpin)]);
        Hotpin = Tall_m(m) + deltaTmin;
        disp(['Hot pinch temp = ', num2str(Hotpin)]);
    end
end

%On hot pinch side, find hot stream and cold stream with lower heat capacity rate
if (mcphot1 > mcphot2)
    mchot = mcphot2;
    Thot = Thot2;
else 
    mchot = mcphot1;
    Thot = Thot1;
end

if(mcpcold1 > mcpcold2)
    mccold = mcpcold2;
    Tcold = Tcold2;
else
        mccold = mcpcold1;
        Tcold = Tcold1;
end
        
if (mchot <= mccold) %check Cc >= Ch
    Qhot1 = mchot*(Thot(2) - Hotpin);
    Qcold1 = mccold*(Tcold(2) - Coldpin);
    if (Qcold1 - Qhot1 == 0)
        disp(['Heat Exchnager duty 1 = ', num2str(Qhot1)]);
    else
        Qrem1 = Qcold1 - Qhot1;
        disp(['Heat Exchnager 1 duty = ', num2str(Qhot1)]);
        disp(['Hot utility 1 = ', num2str(Qrem1)]);
    end
end

%On hot pinch side, find hot stream and cold stream with higher heat capacity rate
if (mcphot1 > mcphot2)
    mchot = mcphot1;
    Thot = Thot1;
else 
    mchot = mcphot2;
    Thot = Thot2;
end

if(mcpcold1 > mcpcold2)
    mccold = mcpcold1;
    Tcold = Tcold1;
else
        mccold = mcpcold2;
        Tcold = Tcold2;
end
        
if (mchot <= mccold) %check Cc >= Ch
    Qhot2 = mchot*(Thot(2) - Hotpin);
    Qcold2 = mccold*(Tcold(2) - Coldpin);
    if (Qcold2 - Qhot2 == 0)
        disp(['Heat Exchnager duty 2 = ', num2str(Qhot2)]);
    else
        Qrem2 = Qcold2 - Qhot2;
        disp(['Heat Exchnager 2 duty = ', num2str(Qhot2)]);
        disp(['Hot utility 2 = ', num2str(Qrem2)]);
    end
end


%On cold pinch side, find hot stream and cold stream with higher heat capacity rate
if (mcphot1 > mcphot2)
    mchot = mcphot1;
    Thot = Thot1;
else 
    mchot = mcphot2;
    Thot = Thot2;
end

if(mcpcold1 > mcpcold2) %cold stream with lower specific capacity rate
    mccold = mcpcold2;
    Tcold = Tcold2;
else
        mccold = mcpcold1;
        Tcold = Tcold1;
end
        
if (mchot >= mccold) %check Ch >= Cc
    Qhot3 = mchot*(Hotpin-Thot(1));
    Qcold3 = mccold*(Coldpin - Tcold(1));
    if (Qhot3 - Qcold3 == 0)
        disp(['Heat Exchnager duty 3 = ', num2str(Qcold3)]);
    else
        Qrem3 = Qhot3-Qcold3;
        disp(['Heat Exchnager 3 duty = ', num2str(Qcold3)]);
            disp(['Cold utility 1 = ', num2str(Qrem3)]);
    end
end