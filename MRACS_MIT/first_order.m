clear; clc; close all;
s = tf('s');

a=-0.5; b=0.5;
aM = 1; bM= 1;
dt = 0.2;
t = 0:dt:50;
r = sin(1*t);
alpha1 = 5;
alpha2 = 5;
G = b/(s+a);
GM = bM/(s+aM);
G_update = 1/(s+aM); %パラメータθの更新に必要な伝達関数

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
    dtheta1 = alpha1 * lsim(G_update, [r(i),0], [0,dt]) * e;
    dtheta1 = dtheta1(2);
    dtheta2 = alpha2 * lsim(G_update, [yi,0], [0,dt]) * e;
    dtheta2 = dtheta2(2);
    theta1 = theta1 + dtheta1;
    theta2 = theta2 + dtheta2;        
    ui = theta1*r(i) + theta2*yi;
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

