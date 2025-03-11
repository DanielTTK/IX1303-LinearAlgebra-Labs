%--------------------------------------------------------------------------
% IX1303: PROJEKTUPPGIFT 1, Linjära ekvationssystem
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%--------------------------------------------------------------------------

clear all

%--------------------------------------------------------------------------
% PROBLEM 1: Numeriska beräkningar av determinanter.
M1 = [1, 4; 
      2, 8];

M2 = [1, 4/3; 1.1, 4.4/3];

determinanten_av_M1 = det(M1);             % Byt ut "0"
determinanten_av_M2 = det(M2);             % Byt ut "0"

% (a) Varför blir inte båda determinanterna exakt noll?
% SVAR: De numeriska beräkningarna kan leda till små avrundningsfel, vilket 
%       innebär att resultaten inte blir exakt noll även om det faktiskt
%       ska vara 0.

% (b) Använd beräkningen för determinanterna ovan får att uppskatta hur
%     stora fel kan vi förvänta oss vid beräkning av determinanter?
% SVAR: Felen kan vara mellan 10^-16 till 10^-15.

%--------------------------------------------------------------------------
% PROBLEM 2: Matrisinverser

m1 = [3; 9; 15];            % Byt ut "0"
m2 = [1; 2; 3];            % Byt ut "0"
m3 = [-3; 6; -3];          % Byt ut "[]"
M  = [m1, m2, m3];

% (a) Vad är vinkeln mellan m1 och m3?
% SVAR: 90 grader
%Skalärprodukten mellan m1 och m3 är 0. Tar man formeln 
%m1 * m3 = |m1||m3| cos(v) i åtanke så måste cos(v) vara 1 om m1*m2
%blir 0. Alltså är vinkeln 90 grader.

% (b) Vad är vinkeln mellan m2 och m3?
% SVAR: Också 90 grader. Samma resonemang

% (c)	Är de tre vektorerna linjärt oberoende?
% SVAR: Ja, eftersom determinanten av M, vilket är determinanten av alla
% tre vektorer i en matris, är inte 0.

determinanten_av_M = det(M);             % Byt ut "0"

% (d) Vad är determinanten av matrisen M? Använd funktionen "det".
% SVAR: Determinanten är 54

% (e) Vilket påstående i "invertable matrix theorem", från Lay's bok, ska
%     man använda tillsammans med svaret i c) för att avgöra om matrisen 
%     M är inverterbar?
% SVAR: Om determinanten är skild från noll så är matrisen inverterbar.

inversen_av_M = inv(M);               % Byt ut "[]"

% (f) Använd Matlab's funktion inv för att beräkna inversen av matrisen M.
%     Är svaret från inv rimligt?
% SVAR: Ja, svaret från inv är rimligt eftersom determinanten är inte noll.


%--------------------------------------------------------------------------
% PROBLEM 3: Matrisers rank och nollrum

m1 = [1; 2; 3];
m2 = [-1; 2; 1];
m3 = [1; 0; 1];                % Byt ut "[]"
m4 = [0; 1; 1];                % Byt ut "[]"
M4 = [m1, m2, m3, m4];

% (a) Vad har matrisen M4 för rang? Använd funktionen "rank".
rank_M4 = rank(M4);
% SVAR: Matrisen M4 har rang 2.

% (b) Hur många pivotkolumner och hur många fria variabler har M4?
%     Notera att detta är relaterat till matrisens rang.
% SVAR: M4 har 2 pivotkolumner och 2 fria variabler.

bas_till_nollrummmet_for_M4 = null(M4);            % Byt ut "[]"

% (c) Vad är nollrummet till M4? För detta kan du använda funktionen null.
%     Notera att svaret måste skrivas på ett matematiskt korrekt sätt, så
%     att det beskriver ett vektorrum. Svaret kan skrivas som en mening,
%     eller med matematisk notation. Talen i vektorerna kan avrundas till
%     att ha fyra decimaler.
% SVAR: [-0.4184,-0.2170;
%        0.3971,-0.2538;
%        0.8156,-0.0368;
%        0.0425,0.9418].


%--------------------------------------------------------------------------
% PROBLEM 4: Ekvationssystem med många obekanta
%
% List över antalet frihetsgrader (värden på n) som ska studeras.
% Här har vi alltså fyra olika fall som ska studeras, först n=3,
% sen n=100, sen n=1000 och till sist n=10000.
nList = [3, 100, 1000, 10000];

% Initiera tidsvektorerna. Här sätter vi alla värden till noll, men inne i
% looper ska ni sätta in den tid det tog att lösa ekvationssystemet.
T_mldivide = zeros(size(nList));
T_inv      = zeros(size(nList));

% Loop över de olika frihetsgraderna.
% Loopen innebär att koden mellan "for" och "end" kommer att köras 4 gånger
% (eftersom length(nList)=4), först med i=1, sen i=2, i=3 och i=4.
for i=1:length(nList)

  % Här skapar vi en variabel n. Värdet på n är 3 först gången vi går
  % igenom loopen, sen 100, 1000 och 10000.
  % Värdet på n är antalet dimensioner hos ekvationssystemet vi ska lösa.
  n=nList(i);

  %----- SKRIV KOD: Skapa nxn matrisen A -----
  %   Här är A=I-C, där C=kR och R är en matris med slumptal
  %   mellan 0 och 1. För att A ska vara inverterbar använder vi k=0.9/n
  k=0.9/n;
  R = rand(n);            % Byt ut "0"
  C = k*R;            % Byt ut "0"
  A = eye(n) - C;            % Byt ut "0"
  
  
  %----- SKRIV KOD:Skapa kolumn-vektorn b -----
  b = rand(n, 1);            % Byt ut "0"
  
  
  tic;
  %----- SKRIV KOD: Lös ekvationssystemet med mldivide -----
  losning_med_mldivide = A \ b;             % Byt ut "0"
  
  tid_mldivide(i)=toc;
  
  
  tic;
  %----- SKRIV KOD: Lös ekvationssystemet med inv -----
  losning_med_inv = inv(A) * b;                  % Byt ut "0"
  
  tid_inv(i)=toc;
  
  
  %----- SKRIV KOD: Beräkna relativa skillnaden mellan lösningarna
  %                 från mldivide och inv                          -----
  relativa_skillnaden = norm(losning_med_mldivide - losning_med_inv) / norm(losning_med_mldivide);              % Byt ut "0"
end


figure; hold on
%----- SKRIV KOD: Rita första figuren -----
plot(nList, tid_mldivide, '-o', 'DisplayName', 'mldivide');
plot(nList, tid_inv, '-x', 'DisplayName', 'inv');
legend;
xlabel('Number of unknowns');
ylabel('Time (seconds)');
title('Time taken to solve equations using mldivide and inv');

figure; hold on
%----- SKRIV KOD: Rita andra figuren -----
plot(nList, relativa_skillnaden, '-o', 'DisplayName', 'Relative Difference');
legend;
xlabel('Number of unknowns');
ylabel('Relative Difference');
title('Relative Difference between solutions from mldivide and inv');


% Frågor:
% (a) Antag att du ska lösa ett problem med tre obekanta en eller ett par
%     gånger. Hur väljer du metod? Är det viktigt att välja rätt metod?
% SVAR: För ett problem med tre obekanta som ska lösas en eller ett par gånger, 
%       kan båda metoderna mldivide och inv användas eftersom det spelar inte
%       så stor roll med tanke på prestanda.  Mldevide är dock klart bättre med
%       tanke på numeriska stabilitet och effektivitet.
%       

% (b) Antag att du ska lösa ett problem med tre obekanta 10 000 gånger.
%     Hur väljer du metod? Är det viktigt att välja rätt metod?
% SVAR: För att lösa ett problem med tre obekanta 10 000 gånger, är det viktigt 
%       att välja en effektiv metod. I detta fall är mldivide den föredragna metoden 
%       eftersom den generellt sett är snabbare och mer numeriskt stabil än inv.

% (c) Antag att du ska lösa ett problem med 10 000 obekanta en eller ett
%     par gånger. Hur väljer du metod? Är det viktigt att välja rätt metod?
% SVAR: För att lösa ett problem med 10 000 obekanta en eller ett par gånger, 
%       är mldivide den rekommenderade metoden eftersom den är mer numeriskt stabil 
%       och hanterar stora matriser bättre än inv, vilket kan vara mer benäget till fel 
%       och ineffektivitet vid så stora problem.

% (d) Kör om alla räkningar tre gånger. Varför får du olika resultat varje
%     gång du kör programmet?
% SVAR: Olika resultat beror på användningen av slumptal vid genereringen av 
%       matrisen R och vektorn b.

% (e) Hur stor är den relativa skillnaden i beräkningstid mellan de två
%     metoderna för 10 000 obekanta?
% SVAR: Relativa skillnaden i beräkningstiden mellan de två metoderna för 10 000 
%       obekanta är betydlig, med mldivide som har mycket snabbare resultat 
%       än inv.