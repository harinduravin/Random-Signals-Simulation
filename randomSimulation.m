L = 100000;
tau = 0;
A = 1;
R = randi([0,1],1,L); %Generates random values
Seq = 2*A*(R-0.5);

N = wgn(1,L ,0); % Generates Noise of variance 1
Inter = wgn(1,L,0); % Generates Interference of variance 1
N1 = wgn(1,L ,6.0205999132); % Power given in dBW
N2 = wgn(1,L ,-10);
N3 = wgn(1,L ,-13.010299956);

var(N)
var(N1) %Checks variance
var(N2)

x = [1:1:L];
y = x;
SN = 3*Seq + N;
SN1 = Seq + N1;
SN2 = Seq + N2;
SN3 = Seq + N3;

p = 0;
q = 0;





%creates two arrays based on the value of S(Conditional)


sym SNpos;
sym SNneg;

for k = 1:L
    if Seq(k)== A
        p = p+1;
        SNpos(p) = 3*Seq(k) + N(k);
    elseif Seq(k)== -A
        q = q+1;
        SNneg(q) = 3*Seq(k) + N(k);
    end
end




%Plots noise+signal for different variance values

subplot(4,1,1)
stairs(x,SN)
title("Variance = 1")
ylim([-10 10])
ax = gca;
ax.TitleFontSizeMultiplier = 2

subplot(4,1,2)
stairs(x,SN1)
title("Variance = 4")
ylim([-10 10])
ax = gca;
ax.TitleFontSizeMultiplier = 2

subplot(4,1,3)
stairs(x,SN2)
title("Variance = 0.1")
ylim([-2 2])
ax = gca;
ax.TitleFontSizeMultiplier = 2

subplot(4,1,4)
stairs(x,SN3)
title("Variance = 0.05")
ylim([-2 2])
ax = gca;
ax.TitleFontSizeMultiplier = 2

for ind = 1:L
    if SN(ind) > tau
        y(ind) = A;
    else
        y(ind) = -1*A;
    end
end





%Plots input signal and received signal in one figure

subplot(2,1,1)
stairs(x,Seq)
title("Transmitted Signal")
ylim([-2 2]);
ax = gca;
ax.TitleFontSizeMultiplier = 2

subplot(2,1,2)
stairs(x,y)
title("Received Signal")
ylim([-2 2]);
ax = gca;
ax.TitleFontSizeMultiplier = 2






% Creates a bar graph equal to a histogram 

Count = [-4.5:1:4.5]
for i = 1:9
    for j = 1:L
        if (SN(j)> (-6 + i)) && (SN(j) < (-5 + i)) 
            Count(i) = Count(i) + 1;
        end
    end
end

xaxis = [-4.5:1:4.5];

bar(xaxis,Count,'r')
title("Histogram without using built in function")
ax = gca;
ax.TitleFontSizeMultiplier = 2

hist(SN,100)
title("Histogram with 100 bins")
ax = gca;
ax.TitleFontSizeMultiplier = 2






% Plots the conditional PDFs

subplot(2,1,1)
[cnts, cents] = hist(SNneg,100);
deltax = cents(2)-cents(1);
bar(cents, cnts/(q*deltax),'g')
title("Conditional PDF f _{R|S}(r|S = -A)")
ax = gca;
ax.TitleFontSizeMultiplier = 2
sum(cents.* cnts)/q % Calculates the Mean of the distribution

subplot(2,1,2)
[cnts, cents] = hist(SNpos,100);
deltax = cents(2)-cents(1);
bar(cents, cnts/(p*deltax),'r')
title("Conditional PDF f _{R|S}(r|S = A)")
ax = gca;
ax.TitleFontSizeMultiplier = 2
sum(cents.* cnts)/p % Calculates the Mean of the distribution






% Plots the PDF

[cnts, cents] = hist(SN,100);
deltax = cents(2)-cents(1);
bar(cents, cnts/(L*deltax),'y')
title("PDF f_{R}(r)")
ax = gca;
ax.TitleFontSizeMultiplier = 2
sum(cents.* cnts)/L % Calculates the Mean of the distribution

