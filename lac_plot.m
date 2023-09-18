Angle =load('Angle.out');
lac =load('Lacunarity(weighted-mean).out');


lac = [lac,lac];

Angle1 = [Angle,Angle+180];

figure
pax = polaraxes;
theta = deg2rad(Angle1);
rho = lac;
polarplot(theta,rho);
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
pax.FontSize = 12;
hold on;
polarplot(0,.5,'-k')
hold off