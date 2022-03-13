clear all
close all
clc

% HW 2 Problem 2 =========================================================
% Define TUid-------------------------------------------------------------
TUid = [9 1 5 9 5 9 2 3 5];
I = TUid(1);
H = TUid(2);
G = TUid(3);
F = TUid(4);
E = TUid(5);
D = TUid(6);
C = TUid(7);
B = TUid(8);
A = TUid(9);

% Define constants--------------------------------------------------------
m = max([E, F, G])*10; %[kg]
b2 = 2; %if upright% [kg/sec]
b1 = 1; %tuck position [kg/sec]
b0 = 0;
g = 9.81; %[m/sec^2]
h = max([A, B, C])*10; %[m]
l = max([E, F, G])*20; %[m]
theta = atan(h/l); %[radians]
Fm = m*g*sin(theta); %[N]

% Needed for for loop below ----------------------------------------------
x = @(t) 0.*t;
t0 = [12];
t = linspace(0,100,1001);
% Vertical motion---------------------------------------------------------
% b = 0
yb0_exact = @(t) h - ((Fm*sin(theta)*t.^2)/(2*m));
for jj = 1
    fb0 = @(t) x(t)-yb0_exact(t);
    t1b0(jj) = fzero(fb0, t0(jj));
end
rhsy_b0 = @(t) RHSy_b0(t,t1b0,Fm,theta);
yb0_sor = second_order_recipe([m b0 0], rhsy_b0, h, 0, t);

% b = 1
yb1_exact =@(t) (h + (Fm*sin(theta)/(b1/m)^2)) * (1 - exp(-(b1*t)/m)) - (Fm*sin(theta)/(b1/m))*(b1*t/m); 
fb1 = @(t) x(t) - yb1_exact(t);
for jj = 1
    t1b1(jj) = fzero(fb1, t0(jj));
end
%t1b1 = 12;
rhsy_b1 = @(t) RHSy_b1(t,t1b1,Fm,theta);
yb1_sor = second_order_recipe([m b1 0], rhsy_b1, h, 0, t);
% b = 2
yb2_exact =@(t) (h + (Fm*sin(theta)/(b2/m)^2)) * (1 - exp(-(b2*t)/m)) - (Fm*sin(theta)/(b2/m))*(b2*t/m);  
fb2 = @(t) x(t) - yb2_exact(t);
for jj = 1
    t1b2(jj) = fzero(fb2, t0(jj));
end
%t1b2 = 12.2;
rhsy_b2 = @(t) RHSy_b2(t,t1b2,Fm,theta);
yb2_sor = second_order_recipe([m b2 0], rhsy_b2, h, 0, t);


% Horizontal motion & Velocity -------------------------------------------
% b = 0
xb0_leg1 = @(t) (Fm*cos(theta).*t.^2)/2;
vb0_leg1 = @(t) (Fm*cos(theta).*t);
xb0_leg2 = @(t) 0.*t;
vb0_leg2 = @(t) 0.*t;

closed_xb0 = xb0_leg1(t);
closed_xb0(t>=t1b0) = xb0_leg2(t(t>=t1b0));

rhsx_b0 = @(t) RHSx_b0(t,t1b0,Fm,theta);
xb0_sor = second_order_recipe([m b0 0], rhsx_b0, 0, 0, t); 

closed_vb0 = vb0_leg1(t);
closed_vb0(t>=t1b0) = vb0_leg2(t(t>=t1b0));
vb0_for = first_order_recipe([b0/m 0], rhsx_b0, 0, t);

% b = 1
xb1_leg1 = @(t) (((Fm*cos(theta)).*t)/(b1/m))-(((Fm*cos(theta)).*t)/(b1/m)^2).*exp(-(b1/m).*t);
xb1_leg1(t1b1);
%v = @(t) diff(xb1_leg1(t));
d = 1e-6;
vb1_leg1 = @(x) (xb1_leg1(x+d)-xb1_leg1(x))/d;
%vb1_leg1 = diff(xb1_leg1);%-(b1/m)*v(t).*t+(Fm*cos(theta).*t);
xb1_leg2 = @(t) xb1_leg1(t1b1)-(1/vb1_leg1(t1b1).*(exp((-b1/m).*t)))+vb1_leg1(t1b1);
%v = @(t) diff(xb1_leg2(t));
vb1_leg2 =  @(x) (xb1_leg2(x+d)-xb1_leg2(x))/d; %@(t) -(b1/m)*v(t)+vb1_leg1(t1b1);
closed_xb1 = xb1_leg1(t);
closed_xb1(t>=t1b1) = xb1_leg2(t(t>=t1b1));
rhsx_b1 = @(t) RHSx_b1(t,t1b1,Fm,theta);
xb1_sor = second_order_recipe([m b1 0], rhsx_b1, 0, 0, t); 
closed_vb1 = vb1_leg1(t);
closed_vb1(t>=t1b1) = vb1_leg2(t(t>=t1b1));
vb1_for = first_order_recipe([b1/m 0], rhsx_b1, 0, t);

% b = 2
xb2_leg1 = @(t) (((Fm*cos(theta)).*t)/(b2/m))-(((Fm*cos(theta)).*t)/(b2/m)^2).*exp(-(b2/m).*t);
%v = @(t) diff(xb2_leg1(t));
vb2_leg1 = @(x) (xb2_leg1(x+d)-xb2_leg1(x))/d; %@(t) -(b2/m)*v(t).*t+(Fm*cos(theta).*t);
xb2_leg2 = @(t) xb2_leg1(t1b2)-(1/vb2_leg1(t1b2).*(exp((-b2/m).*t)))+vb2_leg1(t1b2);
%v = @(t) diff(xb2_leg2(t));
vb2_leg2 = @(x) (xb2_leg2(x+d)-xb2_leg2(x))/d; %-(b2/m)*v(t)+vb1_leg1(t1b2);
closed_xb2 = xb2_leg1(t);
closed_xb2(t>=t1b2) = xb2_leg2(t(t>=t1b2));
rhsx_b2 = @(t) RHSx_b2(t,t1b2,Fm,theta);
xb2_sor = second_order_recipe([m b2 0], rhsx_b2, 0, 0, t); 
closed_vb2 = vb2_leg1(t);
closed_vb2(t>=t1b2) = vb2_leg2(t(t>=t1b2));
vb2_for = first_order_recipe([b2/m 0], rhsx_b2, 0, t);


% t90---------------------------------------------------------------------
tt = linspace(0,10000,1000);
closed_x90 = xb1_leg1(tt);
closed_x90(tt>=t1b1) = xb1_leg2(tt(tt>=t1b1));
x90 = (max(closed_x90))*0.90;
t90 = zeros(size(1));
ff = @(tt) xb1_leg1(t1b1)+(vb1_leg1(t1b1))/(b1/m).*(1-exp((-b1/m).*(tt-t1b1)))-x90;
for jj=1
t90(jj) = fzero(ff,tt(jj));
end
t90rounded = round(t90);

% Plotting----------------------------------------------------------------
t = linspace(0,t90rounded,1001);
subplot(2,1,1);
plot(t, closed_xb0,'b',t, closed_xb1,'r',t, closed_xb2,'g',...
     t, xb0_sor, 'ob', t, xb1_sor, 'ob', t, xb2_sor, 'ob')
legend('...','...','...','...','...','...');
title('Horizontal Motion vs. Time');

subplot(2,1,2);
plot(t, closed_vb0,'b',t, closed_vb1,'r',t, closed_vb2,'g',...
     t, vb0_for, 'ob', t, vb1_for, 'ob', t, vb2_for, 'ob');
legend('...','...','...','...','...','...');
title('Velocity vs. Time');

% rhs functions-----------------------------------------------------------
% b = 0
function fooy_b0 = RHSy_b0(t,t1b0,Fm,theta)
fooy_b0 = zeros(size(t));
fooy_b0(t<=t1b0) = -Fm.*sin(theta);
end
function foox_b0 = RHSx_b0(t,t1b0,Fm,theta)
foox_b0 = zeros(size(t));
foox_b0(t<=t1b0) = Fm.*cos(theta);
end

% b = 1
function fooy_b1 = RHSy_b1(t,t1b1,Fm,theta)
fooy_b1 = zeros(size(t));
fooy_b1(t<=t1b1) = -Fm.*sin(theta);
end
function foox_b1 = RHSx_b1(t,t1b1,Fm,theta)
foox_b1 = zeros(size(t));
foox_b1(t<=t1b1) = Fm.*cos(theta);
end

% b = 2
function fooy_b2 = RHSy_b2(t,t1b2,Fm,theta)
fooy_b2 = zeros(size(t));
fooy_b2(t<=t1b2) = -Fm.*sin(theta);
end
function foox_b2 = RHSx_b2(t,t1b2,Fm,theta)
foox_b2 = zeros(size(t));
foox_b2(t<=t1b2) = Fm.*cos(theta);
end
