% CV measurement using Translating scanline technique 
% Input = Image
% Output = Cv plot for scanline translated from N to S and E to W
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; close all; clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Image = imread('fracplot_hornya.bmp');             % Read image
 [Nrow, Ncol] = size(Image);                        % Image size 
%%%%%%%%%%%%%%%%%%%%%%%%% N-S scanline motion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 cv1 = [];                              % Initiate Cv matrix
 cv2 = [];
 X1 = [];                               % Initiate X axis for plot
 X2 = [];  
 width = 5;                             % space increment b/w adjescent scanline

for I1 = 1: width: Nrow;
 c = Image(I1,:) ;                      % Select the Column/Raw  

%%%%%%%%%%%%%%%%%%%%%%%% Measure Spacing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = c;
B = find(A == 1);
C = length(B);
D = [];
for i = 2:C
    if B(i)-1~=B(i-1)
D(end+1) = B(i)-B(i-1)-1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cv1(end+1) =  std(D)/mean(D);    % Evaluate Cv
X1(end+1) = I1;
end





%%%%%%%%%%%%%%%%%%%%%% E-W Scanline motion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for I2 = 1: width: Ncol;
 c = Image(:,I2) ;               % Select the column  
A = c;
B = find(A == 1);
C = length(B);
D = [];
for i = 2:C
    if B(i)-1~=B(i-1)
D(end+1) = B(i)-B(i-1)-1;
    end
end
%g
cv2(end+1) =  std(D)/mean(D);    % Evaluate Cv
X2(end+1) = I2;
end
length(cv1);
one = ones(1,length(cv1));       

%%%%%%%%%%%%%%%%%%%%%%%%%%%  Plot   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(X1,cv1,X2,cv2,X1,one);
legend('y = Cv(scanline moving form N to S)','y = Cv (scanline moving E to W)','CV=1')
xlabel('Distance'),ylabel('Cv')
axis([0 Nrow -1 3]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






















