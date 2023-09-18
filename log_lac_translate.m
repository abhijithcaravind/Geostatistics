% code  : to calculate lacunarity (1 D) for translating scanline technique
% input : minimum box size, maximum box size, no of steps to skip inbetween        
% ouput :  Lacunarity(Weighted mean log) plot for scanline translated from 
%          both N to S and E to W


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; close all; clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Image = imread('bruce_roy_2sets.bmp');    % Read image                 
[Nrow, Ncol] = size(Image);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
steps = 5;
minbox = 5; N = Ncol;                        % N = max box size
t = 0;                                       % variable               
k = length(1:5:Nrow);
lac = [];
%lac1 = zeros(c,k);
plotspace = 1:5:Nrow;
plotspace1 = 1:5:Ncol;
box_size=(minbox:steps:N);
max_boxsize = max(box_size); 
sumlogrbyrmax = [];
for  I = 1 : 5 : Nrow;                     % Select raw/column    
A = Image(I,:);                        
A = double(A) ;
t=t+1;
c=0;
len = length(A);  
window = []; 
logrbyrmax = [];
for wind = 1:len;                 % wind = size of the glider box
mom1 = 0;mom2 = 0;v=0;
w = ones(1,wind);
s = conv(A,w,'valid');
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
sum_lacxr = sum(lacxrbyrmax);
% sum_box_size = sum(box_size);
weighted_mean = sum_lacxr./sumlogrbyrmax;



box_size=(minbox:steps:N);
max_boxsize = max(box_size); 
sumlogrbyrmax1 = [];
t=0;
for  I = 1 : 5 : Ncol;                     % Select raw/column    
A = Image(:,I);                         
A = double(A);
t=t+1;
c=0;

len = length(A);  
window = []; 
logrbyrmax1 = [];
for wind = 1:len;                 % wind = size of the glider box
mom1 = 0;mom2 = 0;v=0;
w = ones(1,wind);
s = conv(A,w,'valid');
 mom1 = mean(s(:));
 v = var(s(:),1);
 mom2 = mom1^2+v;
 c = c+1;
 lac(c,t) = mom2/(mom1^2);
lacxrbyrmax1(c,t) = log10(lac(c,t))*(log10(wind/len));
logrbyrmax1(end+1) =  (log10(wind/len));
end
sumlogrbyrmax1(end+1) = sum(logrbyrmax1);
end
sum_lacxr1 = sum(lacxrbyrmax1);

weighted_mean1 = sum_lacxr1./sumlogrbyrmax1;

plot(plotspace,weighted_mean,plotspace1,weighted_mean1)
legend('Scanline moving form N to S','Scanline moving form E to W')



