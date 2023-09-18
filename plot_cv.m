Angle=load('angle.out')
circ_CV = load('CV.out')
circ_CV = [circ_CV,circ_CV];

Angle1 = [Angle,Angle+180];


figure
pax = polaraxes;
theta = deg2rad(Angle1);
rho = circ_CV;
polarplot(theta,rho);
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
pax.FontSize = 12;
hold on;
polarplot(0,2,'-k')
hold off