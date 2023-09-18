% code  : to calculate lacunarity (1 D) for rotating scanline technique
% input : Image,        
% ouput : 1)'Lacunarity(weighted-mean).out': for weighted mean of log values
%            of lacunarity
%         2) 'Angle.out' : representing the corresponding angles for rotation
% Use lac_plot.m for plotting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; close all; clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Image = imread('bruce_roy_2sets.bmp');

[Nrow1,Ncol1] = size(Image);
Image = Image(1:Ncol1,1:Ncol1);
[Nrow, Ncol] = size(Image);
%%%%% Define the boundary of the image(to avoid  extra elements while image rotation)
Image1 = ones(Nrow+2,Ncol+2);
for i = 1:Nrow
    for j = 1:Ncol
      Image1(i+1,j+1) = Image(i,j);
    end  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
[Nrow1, Ncol1] = size(Image1);                    % N = max box size
t=0;  

% max_boxsize = max(box_size) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Angstart = 0;                    % Starting Angle 
Angspace = 5;                    % Angles to skip inbetween 
Angend = 180;                    % Ending angle  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k = length(Angstart:Angspace:Angend);
lac = [];                % lacunarity matrix
loglac = [];
maxlac = [];
plotangle = Angstart:Angspace:Angend;
sumlogrbyrmax = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for angle = Angstart : Angspace : Angend;            
 Imrot = imrotate(Image1,angle);             % Rotate image  
 [Nrow1, Ncol1] = size(Imrot); 
 if angle > 180 & angle < 360;
    Ncol1 = Ncol1-1;
 end
A = Imrot(:,round((Ncol1+1)/2));                            
A = double(A);
z = length(A) ;
%%%%%%%%%%%%%%%%%%%%%%% Detect the boundary and crop  %%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:1:z;
if A(i)==1;
    k1 = i;
    break
end
end
for i = z:-1:1;
if A(i)==1;
    k2 = i;
    break
end
end
A1 = A((k1+1):(k2-1),1);
len = length(A1);  
c = 0;
window = []; 
t = t+1;
logrbyrmax = [];
%%%%%%%%%%%%%%%%%%%%%%%% Evaluate lacunarity %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for wind = 1:len;               % wind = size of the glider box
mom1 = 0;
mom2 = 0;
v = 0;
w = ones(1,wind);
s = conv(A1,w,'valid');
mom1 = mean(s(:));
v = var(s(:),1);
mom2 = mom1^2+v;
c = c+1;
lac(c,t) = mom2/(mom1^2);
lacxrbyrmax(c,t) = log10(lac(c,t))*(log10(wind/len));
logrbyrmax(end+1) =  (log10(wind/len));
 end
 sumlogrbyrmax(end+1) = sum(logrbyrmax);
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 sum_lacxr = sum(lacxrbyrmax);
 weighted_mean = sum_lacxr./sumlogrbyrmax;
 dlmwrite('Angle.out',plotangle);
 dlmwrite('Lacunarity(weighted-mean).out',weighted_mean)
