% ikili Kodlu Genetik Algoritma Uygulamasi
% f(X1, X2) = (100*(x2-x1^2))^2 + (x1-1)^2;
% Fonksiyonun min degeri bulunacak
clear
clc
% Canon FN38S Fırçalı DC Motor, 24V, x rpm, 0.78A
m = 0.46;          % mass of uav, 0.486            (kg)
g = 9.81;          % gravity                       (m/s^2)
r = 0.127;          % distance of mass center,0.225 (m) 
I_x = 2.24e-3;    % moment of inertia of uav      (kg.m^2)
I_y = 2.9e-3;
I_z = 5.3e-3;

% GN = input('Jenerasyon Sayisi: ');
% PN = input('Populasyon Buyuklugu: ');
% CO = input('Caprazlama Orani (%): ');
% MO = input('Mutasyon Orani (%):');
%Hassasiyet = input('Ondalik Hassasiyet: ');
GN=40;
PN=20;
CO=85;
MO=20;
Hassasiyet = 0;

Xmin = ones(1,18);
Xmax = [10 20 20 10 20 20 10 20 20 10 20 20 10 20 20 10 20 20];

BestFitness = 10000000;
Params = zeros(PN, 18);
Fitness = zeros(PN, 1);
resultFile = sprintf('Sonuclar.txt');
fid = fopen(resultFile, 'wt');

% Baslangic populasyonunun olusturulmasi

% for i=1:18
% temp_var = strcat( 'X', num2str(i),'Range');
% eval(sprintf('%s = %g',temp_var,(Xmax(i) - Xmin(i)) * (10 ^ Hassasiyet)));
% end
X1Range = (Xmax(1) - Xmin(1)) * (10 ^ Hassasiyet);
X2Range = (Xmax(2) - Xmin(2)) * (10 ^ Hassasiyet);
X3Range = (Xmax(3) - Xmin(3)) * (10 ^ Hassasiyet);
X4Range = (Xmax(4) - Xmin(4)) * (10 ^ Hassasiyet);
X5Range = (Xmax(5) - Xmin(5)) * (10 ^ Hassasiyet);
X6Range = (Xmax(6) - Xmin(6)) * (10 ^ Hassasiyet);
X7Range = (Xmax(7) - Xmin(7)) * (10 ^ Hassasiyet);
X8Range = (Xmax(8) - Xmin(8)) * (10 ^ Hassasiyet);
X9Range = (Xmax(9) - Xmin(9)) * (10 ^ Hassasiyet);
X10Range = (Xmax(10) - Xmin(10)) * (10 ^ Hassasiyet);
X11Range = (Xmax(11) - Xmin(11)) * (10 ^ Hassasiyet);
X12Range = (Xmax(12) - Xmin(12)) * (10 ^ Hassasiyet);
X13Range = (Xmax(13) - Xmin(13)) * (10 ^ Hassasiyet);
X14Range = (Xmax(14) - Xmin(14)) * (10 ^ Hassasiyet);
X15Range = (Xmax(15) - Xmin(15)) * (10 ^ Hassasiyet);
X16Range = (Xmax(16) - Xmin(16)) * (10 ^ Hassasiyet);
X17Range = (Xmax(17) - Xmin(17)) * (10 ^ Hassasiyet);
X18Range = (Xmax(18) - Xmin(18)) * (10 ^ Hassasiyet);

X1KacBit = length(dec2bin(X1Range));
X2KacBit = length(dec2bin(X2Range));
X3KacBit = length(dec2bin(X3Range));
X4KacBit = length(dec2bin(X4Range));
X5KacBit = length(dec2bin(X5Range));
X6KacBit = length(dec2bin(X6Range));
X7KacBit = length(dec2bin(X7Range));
X8KacBit = length(dec2bin(X8Range));
X9KacBit = length(dec2bin(X9Range));
X10KacBit = length(dec2bin(X10Range));
X11KacBit = length(dec2bin(X11Range));
X12KacBit = length(dec2bin(X12Range));
X13KacBit = length(dec2bin(X13Range));
X14KacBit = length(dec2bin(X14Range));
X15KacBit = length(dec2bin(X15Range));
X16KacBit = length(dec2bin(X16Range));
X17KacBit = length(dec2bin(X17Range));
X18KacBit = length(dec2bin(X18Range));

ToplamKacBit = X1KacBit + X2KacBit + X3KacBit + X4KacBit+ X5KacBit+ X6KacBit+X7KacBit + X8KacBit + X9KacBit + X10KacBit+ X11KacBit+ X12KacBit+X13KacBit + X14KacBit + X15KacBit + X16KacBit+ X17KacBit+ X18KacBit;
Population = round(rand(PN, ToplamKacBit));

fprintf(fid, '\nGeneration: %d  Population: %d  Crossover: %.2f  Mutation: %.2f  Bit Sayisi: %d\n\n', GN, PN, CO/100, MO/100, ToplamKacBit);
fprintf(fid, 'Nesil\t\tToplam Uygunluk\t\tEn iyi Uygunluk\t\tX1\t\tX2\tX3\n');

% Uygunluk degerlerinin hesaplanmasi
for j=1:1:PN
    x1tostr = int2str(Population(j, 1:X1KacBit));
    x2tostr = int2str(Population(j, X1KacBit+1:X1KacBit+X2KacBit));
    x3tostr = int2str(Population(j, X1KacBit+X2KacBit+1:X1KacBit+X2KacBit+X3KacBit));
    x4tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit));
    x5tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit));
    x6tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit));
    x7tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit));
    x8tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit));
    x9tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit));
    x10tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit));
    x11tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit));
    x12tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit));
    x13tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit+X13KacBit));
    x14tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+X13KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit));
    x15tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit));
    x16tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit+X16KacBit));
    x17tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit+X16KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit+X16KacBit+X17KacBit));
    x18tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit+X16KacBit+X17KacBit+1:ToplamKacBit));

    decimalX1 = bin2dec(x1tostr);
    decimalX2 = bin2dec(x2tostr);
    decimalX3 = bin2dec(x3tostr);
    decimalX4 = bin2dec(x4tostr);
    decimalX5 = bin2dec(x5tostr);
    decimalX6 = bin2dec(x6tostr);
    decimalX7 = bin2dec(x7tostr);
    decimalX8 = bin2dec(x8tostr);
    decimalX9 = bin2dec(x9tostr);
    decimalX10 = bin2dec(x10tostr);
    decimalX11 = bin2dec(x11tostr);
    decimalX12 = bin2dec(x12tostr);
    decimalX13 = bin2dec(x13tostr);
    decimalX14 = bin2dec(x14tostr);
    decimalX15 = bin2dec(x15tostr);
    decimalX16 = bin2dec(x16tostr);
    decimalX17 = bin2dec(x17tostr);
    decimalX18 = bin2dec(x18tostr);
  
    X1 = Xmin(1) + (decimalX1 * ((Xmax(1) - Xmin(1)) / (2 ^ X1KacBit - 1)));
    X2 = Xmin(2) + (decimalX2 * ((Xmax(2) - Xmin(2)) / (2 ^ X2KacBit - 1)));
    X3 = Xmin(3) + (decimalX3 * ((Xmax(3) - Xmin(3)) / (2 ^ X3KacBit - 1)));
    X4 = Xmin(4) + (decimalX4 * ((Xmax(4) - Xmin(4)) / (2 ^ X4KacBit - 1)));
    X5 = Xmin(5) + (decimalX5 * ((Xmax(5) - Xmin(5)) / (2 ^ X5KacBit - 1)));
    X6 = Xmin(6) + (decimalX6 * ((Xmax(6) - Xmin(6)) / (2 ^ X6KacBit - 1)));
    X7 = Xmin(7) + (decimalX7 * ((Xmax(7) - Xmin(7)) / (2 ^ X7KacBit - 1)));
    X8 = Xmin(8) + (decimalX8 * ((Xmax(8) - Xmin(8)) / (2 ^ X8KacBit - 1)));
    X9 = Xmin(9) + (decimalX9 * ((Xmax(9) - Xmin(9)) / (2 ^ X9KacBit - 1)));
    X10 = Xmin(10) + (decimalX10 * ((Xmax(10) - Xmin(10)) / (2 ^ X10KacBit - 1)));
    X11 = Xmin(11) + (decimalX11 * ((Xmax(11) - Xmin(11)) / (2 ^ X11KacBit - 1)));
    X12 = Xmin(12) + (decimalX12 * ((Xmax(12) - Xmin(12)) / (2 ^ X12KacBit - 1)));
    X13 = Xmin(13) + (decimalX13 * ((Xmax(13) - Xmin(13)) / (2 ^ X13KacBit - 1)));
    X14 = Xmin(14) + (decimalX14 * ((Xmax(14) - Xmin(14)) / (2 ^ X14KacBit - 1)));
    X15 = Xmin(15) + (decimalX15 * ((Xmax(15) - Xmin(15)) / (2 ^ X15KacBit - 1)));
    X16 = Xmin(16) + (decimalX16 * ((Xmax(16) - Xmin(16)) / (2 ^ X16KacBit - 1)));
    X17 = Xmin(17) + (decimalX17 * ((Xmax(17) - Xmin(17)) / (2 ^ X17KacBit - 1)));
    X18 = Xmin(18) + (decimalX18 * ((Xmax(18) - Xmin(18)) / (2 ^ X18KacBit - 1)));

    Params(j, 1) = X1;
    Params(j, 2) = X2;
    Params(j, 3) = X3;
    Params(j, 4) = X4;
    Params(j, 5) = X5;
    Params(j, 6) = X6;
    Params(j, 7) = X7;
    Params(j, 8) = X8;
    Params(j, 9) = X9;
    Params(j, 10) = X10;
    Params(j, 11) = X11;
    Params(j, 12) = X12;
    Params(j, 13) = X13;
    Params(j, 14) = X14;
    Params(j, 15) = X15;
    Params(j, 16) = X16;
    Params(j, 17) = X17;
    Params(j, 18) = X18;

    Fitness(j,1) = uav_cost_function(Params(j,:),0);
end

[minFitness, minIndex] = min(Fitness);
fprintf(fid, '%d\t\t%.3f\t\t\t%.3f\t\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\n', i, sum(Fitness), minFitness, Params(minIndex, 1), Params(minIndex, 2),Params(minIndex, 3),Params(minIndex, 4));

tic
for i=1:GN

    if(minFitness < BestFitness) 
       BestFitness = minFitness;
       BestGN = i;
    end

% Dogal Secim islemi
    reverseFitness = 1 ./ Fitness;
    Probability = reverseFitness / sum(reverseFitness);
    Cumulative = cumsum(Probability);
    RandomSNum = rand(PN, 1);

    for j=1:PN
       index = find(RandomSNum < Cumulative(j));
       RandomSNum(index) = j*ones(size(index));
    end

    Population = Population(RandomSNum, :);

% Caprazlama islemi
    RandomCNum = rand(PN, 1);
    index = find(RandomCNum < (CO/100));
    CONum = length(index); 

    while CONum < ceil(PN*(CO/100))
        index(CONum+1) = round(rand * PN);
        if index(CONum+1) == 0
            continue;
        end
        CONum = length(index);
    end
    while CONum > ceil(PN*(CO/100))
        index(CONum) = [];
        CONum = length(index);
    end
    while mod(CONum,2) == 1
        index(CONum + 1) = round(rand * PN);
        if index(CONum + 1) == 0
            continue;
        end
        CONum = length(index);
    end
    
    CONum = length(index);

    for j=1:CONum/2
        CrossPoint = ceil(rand * (ToplamKacBit-1));
        Bitler = Population(index(2*j-1), CrossPoint+1:ToplamKacBit);
        Population(index(2*j-1), CrossPoint+1:ToplamKacBit) = Population(index(2*j), CrossPoint+1:ToplamKacBit);
        Population(index(2*j), CrossPoint+1:ToplamKacBit) = Bitler;
    end

% Mutasyon islemi
    if(i ~= GN)
        RandomMNum = rand(PN*ToplamKacBit, 1);
        index = find(RandomMNum < (MO/100));
        MONum = length(index); 

        for j=1:MONum
            Kromozom = ceil(index(j)/ToplamKacBit);
            Konum = mod(index(j),ToplamKacBit);
            if Konum == 0
              Konum = ToplamKacBit; 
            end
            Population(Kromozom, Konum) = ~ Population(Kromozom, Konum);  
        end
    end

% Uygunluk degerlerinin hesaplanmasi
    for j=1:1:PN       
        x1tostr = int2str(Population(j, 1:X1KacBit));
        x2tostr = int2str(Population(j, X1KacBit+1:X1KacBit+X2KacBit));
        x3tostr = int2str(Population(j, X1KacBit+X2KacBit+1:X1KacBit+X2KacBit+X3KacBit));
        x4tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit));
        x5tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit));
        x6tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit));
        x7tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit));
        x8tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit));
        x9tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit));
        x10tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit));
        x11tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit));
        x12tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit));
        x13tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit+X13KacBit));
        x14tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+X13KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit));
        x15tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit));
        x16tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit+X16KacBit));
        x17tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit+X16KacBit+1:X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit+X16KacBit+X17KacBit));
        x18tostr = int2str(Population(j, X1KacBit+X2KacBit+X3KacBit+X4KacBit+X5KacBit+X6KacBit+X7KacBit+X8KacBit+X9KacBit+X10KacBit+X11KacBit+X12KacBit+X13KacBit+X14KacBit+X15KacBit+X16KacBit+X17KacBit+1:ToplamKacBit));

        decimalX1 = bin2dec(x1tostr);
        decimalX2 = bin2dec(x2tostr);
        decimalX3 = bin2dec(x3tostr);
        decimalX4 = bin2dec(x4tostr);
        decimalX5 = bin2dec(x5tostr);
        decimalX6 = bin2dec(x6tostr);
        decimalX7 = bin2dec(x7tostr);
        decimalX8 = bin2dec(x8tostr);
        decimalX9 = bin2dec(x9tostr);
        decimalX10 = bin2dec(x10tostr);
        decimalX11 = bin2dec(x11tostr);
        decimalX12 = bin2dec(x12tostr);
        decimalX13 = bin2dec(x13tostr);
        decimalX14 = bin2dec(x14tostr);
        decimalX15 = bin2dec(x15tostr);
        decimalX16 = bin2dec(x16tostr);
        decimalX17 = bin2dec(x17tostr);
        decimalX18 = bin2dec(x18tostr);  
    
        X1 = Xmin(1) + (decimalX1 * ((Xmax(1) - Xmin(1)) / (2 ^ X1KacBit - 1)));
        X2 = Xmin(2) + (decimalX2 * ((Xmax(2) - Xmin(2)) / (2 ^ X2KacBit - 1)));
        X3 = Xmin(3) + (decimalX3 * ((Xmax(3) - Xmin(3)) / (2 ^ X3KacBit - 1)));
        X4 = Xmin(4) + (decimalX4 * ((Xmax(4) - Xmin(4)) / (2 ^ X4KacBit - 1)));
        X5 = Xmin(5) + (decimalX5 * ((Xmax(5) - Xmin(5)) / (2 ^ X5KacBit - 1)));
        X6 = Xmin(6) + (decimalX6 * ((Xmax(6) - Xmin(6)) / (2 ^ X6KacBit - 1)));
        X7 = Xmin(7) + (decimalX7 * ((Xmax(7) - Xmin(7)) / (2 ^ X7KacBit - 1)));
        X8 = Xmin(8) + (decimalX8 * ((Xmax(8) - Xmin(8)) / (2 ^ X8KacBit - 1)));
        X9 = Xmin(9) + (decimalX9 * ((Xmax(9) - Xmin(9)) / (2 ^ X9KacBit - 1)));
        X10 = Xmin(10) + (decimalX10 * ((Xmax(10) - Xmin(10)) / (2 ^ X10KacBit - 1)));
        X11 = Xmin(11) + (decimalX11 * ((Xmax(11) - Xmin(11)) / (2 ^ X11KacBit - 1)));
        X12 = Xmin(12) + (decimalX12 * ((Xmax(12) - Xmin(12)) / (2 ^ X12KacBit - 1)));
        X13 = Xmin(13) + (decimalX13 * ((Xmax(13) - Xmin(13)) / (2 ^ X13KacBit - 1)));
        X14 = Xmin(14) + (decimalX14 * ((Xmax(14) - Xmin(14)) / (2 ^ X14KacBit - 1)));
        X15 = Xmin(15) + (decimalX15 * ((Xmax(15) - Xmin(15)) / (2 ^ X15KacBit - 1)));
        X16 = Xmin(16) + (decimalX16 * ((Xmax(16) - Xmin(16)) / (2 ^ X16KacBit - 1)));
        X17 = Xmin(17) + (decimalX17 * ((Xmax(17) - Xmin(17)) / (2 ^ X17KacBit - 1)));
        X18 = Xmin(18) + (decimalX18 * ((Xmax(18) - Xmin(18)) / (2 ^ X18KacBit - 1)));

        Params(j, 1) = X1;
        Params(j, 2) = X2;
        Params(j, 3) = X3;
        Params(j, 4) = X4;
        Params(j, 5) = X5;
        Params(j, 6) = X6;
        Params(j, 7) = X7;
        Params(j, 8) = X8;
        Params(j, 9) = X9;
        Params(j, 10) = X10;
        Params(j, 11) = X11;
        Params(j, 12) = X12;
        Params(j, 13) = X13;
        Params(j, 14) = X14;
        Params(j, 15) = X15;
        Params(j, 16) = X16;
        Params(j, 17) = X17;
        Params(j, 18) = X18;
        
        Fitness(j,1) = uav_cost_function(Params(j,:),0);
    end
    [minFitness, minIndex] = min(Fitness);
    fprintf(fid, '%d\t\t%.3f\t\t\t%.3f\t\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\n', i, sum(Fitness), minFitness, Params(minIndex, 1), Params(minIndex, 2),Params(minIndex, 3),Params(minIndex, 4),Params(minIndex, 5),Params(minIndex, 6),Params(minIndex, 7),Params(minIndex, 8),Params(minIndex, 9),Params(minIndex, 10),Params(minIndex, 11),Params(minIndex, 12),Params(minIndex, 13),Params(minIndex, 14),Params(minIndex, 15),Params(minIndex, 16),Params(minIndex, 17),Params(minIndex, 18));
end
toc 
fprintf(fid, '\n\n%d. iterasyonda en iyi uygunluk degeri: %.3f\n', BestGN-1, BestFitness);

fclose(fid);
fprintf('%d. iterasyonda en iyi uygunluk degeri: %.3f\n', BestGN-1, BestFitness);


