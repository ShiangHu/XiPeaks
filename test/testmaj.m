clc; 
clear;
z = 1:100; z=z';
y1 = log(z);
y2 = (z-1) - 0.5*(z-1).^2;
figure,plot([y1,y2]); legend({'y1','y2'})