clear; clc; close all;
s = tf('s');

a=-0.5; b=0.5;
aM = 1; bM= 1;
dt = 0.1;
t = 0:dt:50;
r = sin(2*t);
alpha1 = 5;
alpha2 = 5;
G = b/(s+a);
GM = bM/(s+aM);

theta1=0;
theta2=0;
yM = lsim(GM,r,t);
yi = 0;
y = [yi];
error = []
for i=1:length(t)
    yMi = yM(i);
    yi = y(end);
    e = yMi - yi;
    ri = r(i);
    dtheta1 = alpha1 * ri * e;
    dtheta2 = alpha2 * yi * e;
    theta1 = theta1 + dtheta1;
    theta2 = theta2 + dtheta2;        
    ui = theta1*ri + theta2*yi;
    yi = lsim(G, [ui,0], [0,dt]);
    yi = yi(2);
    y(end+1) = yi;
    error(end+1)=e;
end

plot(t,yM);
hold on;
plot(t,y(1:end-1));

yyaxis right;
% plot(t,e,'--');
semilogy(t,error,'k--');
legend('Model reference','Output','error');

big;

