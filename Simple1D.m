%initialization
clc;
clear;
close all;

%Inputs
er = 1; %relative permittivity
v0 = 1; %volt
d = 8; %centimeter
p0 = 10e-8; %C/m^3
e0 = 8.85e-12; % F/m

%calculations
d = d * 1e-2;
x = linspace(0, d, 100);

vx = ((p0)/(2*er*e0)) * x.^2 - ((p0*d)/(2*er*e0)+ v0/d) * x + v0;

plot(x, vx, '--', 'color', 'b');
xlabel("Distance (m)");
ylabel("Voltage (V)");