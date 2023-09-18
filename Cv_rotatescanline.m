% CV measurement using Rotating scanline technique 
% Input = Image
% Output = CV.out with values of cv from 0 to 180 starting from North
%          angle.out with values of angle
% Use plot_cv.m for plotting


clc; close all; clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Image = imread('bruce_roy_2sets.bmp');
[Nrow, Ncol] = size(Image);
%%%%%%%%%%%%%%%%%%%%%% Add a border to the image %%%%%%%%%%%%%%%%%%%%%%%%%%
Image1 = ones(Nrow+2,Ncol+2);

for i = 1:Nrow
    for j = 1:Ncol
      Image1(i+1,j+1) = Image(i,j);
    end
end
    
%%%%%%%%%%%%%%%%%%%%%%%%% Rotate Scanline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cv = [];                         % Initiate array for cv
Ang1 = [];                       % Initiate X axis of the plot

Angstart = 0;                    % Starting Angle 
Angspace = 2;                    % Angles to skip inbetween 
Angend = 180;                    % Ending angle  

 for angle = Angstart : Angspace : Angend;            
 Imrot = imrotate(Image1,angle); 
 [Nrow1, Ncol1] = size(Imrot); 
if angle > 180 & angle < 360;
    Ncol1 = Ncol1-1;   
 end
c = Imrot(:,round((Ncol1+1)/2));                % Select the Column 

 z = length(c);                                 % total length of the column                                    
 t = 0;                                         % variable 

%%%%%%%%%%%%%%%%%%%% resize the scanline after %%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:1:z;
if c(i)==1;
    k1 = i;
    break
end
end
for i = z:-1:1;
if c(i)==1;
    k2 = i;
    break
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = c(k1:k2);                                   % Modified scanline

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Evaluate spacing %%%%%%%%%%%%%%%%%%%%%%%%%%%%
B = find(A == 1);
C = length(B);
D = [];
for i = 2:C
    if B(i)-1~=B(i-1)
D(end+1) = B(i)-B(i-1)-1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Evaluate Cv %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%g
cv(end+1) =  std(D)/mean(D);  
Ang1(end+1) = angle;
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dlmwrite('CV.out',cv);
dlmwrite('angle.out',Ang1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






















