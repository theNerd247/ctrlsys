% load the results of the simulation
clear all
close all

pkg load statistics

rawData = csvread('results/lab2results/part3.csv');

xrange=1:1:7;

x = rawData(xrange,3);
ys = rawData(xrange,6);
%ys(xrange,4) = ys(xrange,4)./100;

%[bs,~,~,~,~] = regress(log(ys'),x)

hold on;
plot(x,ys');
scatterColors(x,ys);


%plot(xl,yl');
legend('tr','tp','ts','%os','ess');
