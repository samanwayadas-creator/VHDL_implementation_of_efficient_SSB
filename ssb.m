%this program calculates the delay between + and - 45 degree phase shift
clear all;
close all; 
fm = 1e3;%Message frq 1Khz
fs=40e3; % sampling frequency
t = 0:1/fs:0.01;
%t = 0:1/fs:0.001;
x = sin(2*pi*fm*t); % message signal
plot(t,x)
A=[0.0000   -0.0000   -0.0000   -0.0103   -0.0000   -0.0336   0   -0.0613    0.0000   -0.0685 -0.0000   -0.0000    0.0000    0.7466         0   -0.3952         0   -0.1540    0.0000   -0.0507 0.0000    0.0000    0.0000    0.0149    0.0000    0.0109         0    0.0032];
N1 = length(A)
filterout_A = filter(A,1,x);%filter A
N=length(filterout_A)
B= fliplr(A);
filterout_B = filter(B,1,x);%filter B
Nb=length(filterout_B)
figure (2)
plot(filterout_A,'m');
hold on;
plot( filterout_B,'r');
X1=fft(filterout_A);
%Y=fft(c1);
Y1=fft(filterout_B);
% Determine the max value and max point.
% This is where the sinusoidal
% is located. 
[mag_X1 idx_X1] = max(abs(X1))
[mag_Y1 idx_Y1] = max(abs(Y1))
% determine the phase difference
% at the maximum point.
pX1 = angle(X1(idx_X1));
pY1 = angle(Y1(idx_Y1));
phase_lag1 = (pY1- pX1)*180/pi;
% determine the amplitude scaling
amplitude_ratio_diff1 = mag_Y1/mag_X1;
phase_lag_diff1=mod(phase_lag1+180,360)-180
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fc = 5e3;%carrier frequency 5KHz
t1 = 0:1/fs:.01;
I=(cos(2*pi*fc*t1));
Q=(sin(2*pi*fc*t1));
As=(filterout_A).*I;
Bs=(filterout_B).*Q;
SSB=As+Bs;
figure(3)
plot(t,SSB)
Y=fft(SSB);
 
L=length(Y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;
figure;
plot(f,P1)
figure;
plot(f,10*log10(P1))  % plot in db
title('Single-Sided Amplitude Spectrum of X(t)')


