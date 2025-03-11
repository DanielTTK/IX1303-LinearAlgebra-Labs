%--------------------------------------------------------------------------
% IX1303-VT2023: PROJEKTUPPGIFT 3, Streckgubben
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%--------------------------------------------------------------------------

clear all

% Beskrivning av gif-filen
filename = 'dashman.gif';
TimePerFrame = 0.05;
NumberOfTimeSteps = 50;

%------------------
% SKAPA MATRISERNA
%------------------

%----- SKRIV KOD: Skapa den matris som rotaterar sträckgubben. 
%                 Du väljer vinkeln på rotationen, men notera att för
%                 att det ska se ut som att sträckgubben roterar måste
%                 rotationen mellan varje bild i filmen vara liten.   -----
theta = pi / 25;
R = [cos(theta) -sin(theta) 0;
     sin(theta)  cos(theta) 0;
     0           0          1];

%----- SKRIV KOD: Skapa den matris som transkaterar sträckgubben.
x = 0.1;
T = [1 0 x;
     0 1 0;
     0 0 1];

%----- SKRIV KOD: Skapa den matris som förstorar sträckgubben.
skala = 1.01;
S = [skala    0        0;
     0        skala    0;
     0        0        1];

%----- SKRIV KOD: Skapa den sammansatta matrisen som 
%                 beskriver den efterfrågade avbildningen -----
FaktorMatrix = T * R * S;
  
%----- UPPDATERA KOD: Finn en "bounding-box" (en zoom-inställning) på formatet:
%                        [x-min, x-max, y-min, y-max]
%                     Så att vi ser gubben tydligt under animeringen - den
%                     får inte försvinna ut ur bilden.
BoundingBox = [-1,1,-1,1]*2.5; % Sänkt faktorn 14 till 2.5 så att den börjar större

%------------------------------
% SKAPA STRECKGUBBEN, DASH-MAN
%------------------------------

D=DashMan();

%-----------------------------------
% SKAPA FÖRSTA BILDEN I ANIMERINGEN
%-----------------------------------
figure(1);
clf; hold on;
plotDashMan(D); % Här ritar vi Dash-man som han ser ut från början
axis equal
%axis(BoundingBox)
%set(gca,'visible','off')
addFrameToGif(filename, 1, TimePerFrame)

%-----------------------------------------------------
% Loopa över alla bilder i animeringen, från 2 till 50
%-----------------------------------------------------
for i = 2:50


  %----- SKRIV KOD: Transformera alla DASH-MAN's kroppsdelar -----
  % Här ska du uppdatera punkter i D, dvs alla punkter i huvudet, kroppen osv.
  D.head = FaktorMatrix * D.head;
  D.mouth = FaktorMatrix * D.mouth;
  D.body = FaktorMatrix * D.body;
  D.legs = FaktorMatrix * D.legs;
  D.arms = FaktorMatrix * D.arms;

  hold off
  plotDashMan(D); % Här ritar vi Dash-man som han ser ut efter transformationen
  axis equal
  axis(BoundingBox)
  set(gca,'visible','off')
  addFrameToGif(filename, i, TimePerFrame)
end


% Frågor:
%	1. Varför innehåller sista raden i D.head bara ettor?
% SVAR: Sista raden innehåller  bara ettor pågrund av den homogena
% koordinatrepresentationen. Detta möjliggör utförande av rotation och
% skalning, samt förflyttningar utan att förlora information om dens
% position i 2D.

% 2. 2.	Beskriv skillnaden i gubbens rörelse över flera varv 
%      (d.v.s banan gubben rör sig längs) när man translaterar uppåt, neråt,
%      åt höger eller vänster?
% SVAR: Gubben rör sig horizontellt (vänster/höger) och vertikalt (upp/ner), 
% en kombination av dessa två ger gubben en mer komplex rörelsebana. Detta
% med effekten av rotationer och så ändrar rörelsebanan också.

% 3. Om man flyttar gubben en sträcka dx=0.1 per steg, och vi tar 50 steg
%    med kombinerad translation och rotation, varför har gubben inte
%    flyttats 50*0.1 åt höger?
% SVAR: Eftersom gubbens rörelse affekteras av rotationer och skalningar.
% Rotationen ändrar gubbens riktning, så varje rörelse vertikalt eller
% horizontellt ändrar riktning. Detta gör gubbens bana kurvad istället för
% rak.




% ----------------------------- Källor --------------------------------
%
%Foley, J. D., van Dam, A., Feiner, S. K., & Hughes, J. F. (1990). 
% Computer Graphics: Principles and Practice (2nd ed.). Addison-Wesley. 
% Available at https://books.google.com/books?id=kJ8_AQAAIAAJ
%
%Hartley, R., & Zisserman, A. (2004). Multiple View Geometry in Computer 
% Vision (2nd ed.). Cambridge University Press. Available at 
% https://www.cambridge.org/core/books/multiple-view-geometry-in-computer-vision/6213D6C9D98B79F56F647E24C22D2BFD
%
%Strang, G. (2006). Linear Algebra and Its Applications (4th ed.). 
% Cengage Learning. Available at 
% https://www.cengage.com/c/linear-algebra-and-its-applications-4e-strang
%
%ChatGPT. (2022). Explanation of Homogeneous Coordinates and 
%Transformations. OpenAI. Available at https://www.openai.com/research/chatgpt
