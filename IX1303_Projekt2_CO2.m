%--------------------------------------------------------------------------
% IX1303: PROJEKTUPPGIFT 2, CO2 mätning
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%-------------------------------------------------------------------------- 
clear all

%----- SKRIV KOD: Fyll i data-filens namn (ta med .csv, .txt, eller liknande) -----
filename="monthly_in_situ_co2_mlo.csv";  % Filen kommer från https://scrippsco2.ucsd.edu
TABLE = readtable(filename);

%----- SKRIV KOD: Fyll i namnen på de kolumner som innehåller tid och data -----
% Visa kolumnnamnen för att identifiera de nödvändiga kolumnerna
disp(TABLE.Properties.VariableNames);

% Anta att kolumnerna heter 'Date' för tid och 'CO2' för mätningarna
T = TABLE.Date;  % Byt ut med det faktiska namnet om annorlunda
y = TABLE.CO2;   % Byt ut med det faktiska namnet om annorlunda

%----- SKRIV KOD: Ta bort alla vektor-element som inte innehåller riktig mätdata -----
T = T(y > 0);
y = y(y > 0);
T = T(isfinite(y));
y = y(isfinite(y));

% Skapa en S-vektor:
S = (T - T(1)) / 30;  % Antag att T är i dagar, detta konverterar till månader

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(S) till en rät linje -----
X1 = [ones(size(S)), S];
b1 = X1 \ y;
beta1 = X1 * b1;

%----- SKRIV KOD: Rita både mätdata och den linjära anpassningen i samma graf. -----
figure('name','Linjär minstakvadratanpassning')
plot(T, y, 'b.')
hold on
plot(T, beta1, 'r-')
xlabel('Tid (månader)')
ylabel('CO2-koncentration (ppm)')
legend('Data', 'Linjär anpassning')
hold off

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(S) till ett 
%                 andragradspolynom (kvadratisk anpassning) -----
X2 = [ones(size(S)), S, S.^2];
b2 = X2 \ y;
beta2 = X2 * b2;

%----- SKRIV KOD: Rita både mätdata och den kvadratiska anpassningen i
%                 samma graf. -----
figure('name','Kvadratisk minstakvadratanpassning')
plot(T, y, 'b.')
hold on
plot(T, beta2, 'r-')
xlabel('Tid (månader)')
ylabel('CO2-koncentration (ppm)')
legend('Data', 'Kvadratisk anpassning')
hold off

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(S) till ett
%                 tredjegradspolynom (kubiska anpassning) -----
X3 = [ones(size(S)), S, S.^2, S.^3];
b3 = X3 \ y;
beta3 = X3 * b3;

%----- SKRIV KOD: Rita både mätdata och den kubiska anpassningen i samma graf. -----
figure('name','Kubisk minstakvadratanpassning')
plot(T, y, 'b.')
hold on
plot(T, beta3, 'r-')
xlabel('Tid (månader)')
ylabel('CO2-koncentration (ppm)')
legend('Data', 'Kubisk anpassning')
hold off

% Frågor:
% 1. Beskriv med egna ord hur de tre kurvorna beskriver mätdata. Framför allt, blir
%    lösningen lite eller mycket bättre när vi går från en rät linje till
%    en andragradsfunktion? Blir den mycket bättre när vi går från en
%    andragradsfunktion till en tredjegradsfunktion?
% SVAR: 
% De tre kurvorna visar olika grader av anpassning till mätdata. Den linjära anpassningen ger 
% en generell trend över tiden men fångar inte upp variationer särskilt väl. När vi går över till 
% en andragradsfunktion förbättras anpassningen mycket eftersom denna modell kan följa upp- och nedgångar 
% bättre. Den tredjegradsfunktionen ger en ännu bättre anpassning eftersom den kan fånga upp mer 
% komplexa mönster i data. Förbättringen är märkbar från linjär till andragrad men mindre tydlig 
% från andragrad till tredjegrad.

% 2. Kan man använda dessa anpassningar för att uppskatta koldioxidhalterna
%    i atmosfärern om 2 år? Motivera ditt svar.
% SVAR: 
% Ja, dessa anpassningar kan användas för att göra kortsiktiga prognoser, som för 2 år framåt, 
% eftersom de baseras på nyliga data och den generella trenden kan antas fortsätta på kort sikt.

% 3. Kan man använda dessa anpassningar för att uppskatta koldioxidhalterna
%    i atmosfärern om 6 månader? Motivera ditt svar.
% SVAR: 
% Ja, de kan användas för att uppskatta koldioxidhalterna om 6 månader. Den kortare tidsperioden 
% gör det troligt att de aktuella trenderna och mönstren håller sig relativt stabila.

% 4. Kan man använda dessa anpassningar för att uppskatta koldioxidhalterna
%    i atmosfärern om 50 år? Motivera ditt svar.
% SVAR: 
% Nej, dessa anpassningar är inte lämpliga för så långsiktiga prognoser. Koldioxidhalterna påverkas 
% av många faktorer som kan förändras över tid, såsom politiska, teknologisk, 
% och naturliga händelser. En långsiktig prognos kräver mer komplexa modeller som tar hänsyn till 
% dessa variabler.