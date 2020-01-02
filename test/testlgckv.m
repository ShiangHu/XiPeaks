clean;
addpath(genpath(cd));
load vctspt;
lmd = 0;

% x = linspace(-2,3,308)';
% x= exp(-x.^2/2+1);
% e = 0.1*(rand(308,1) - 0.3);
% pks_real = x;
load pks_real

% smoothing
nf = length(freq);
C = diff(eye(nf),3); 
C = sparse(C'*C); 

% 2nd diff
D = sparse(diff(eye(nf),2));
w = 2*abs(freq - freq(pks_real==max(pks_real)))/max(freq);

% fmin
fun = @(n)uniobj(n,pks_real,lmd,C);
x0 = log(pks_real);
% x0 = log(x0);
A = D;
b = zeros(nf-2,1);
Aeq =[];
beq = [];
% lb  = x0 - w*mean(abs(x0));
% ub = x0 + w*mean(abs(x0));
lb = [];
ub = [];
nonlcon = [];
pks_up = fmincon(fun, x0, A, b, Aeq, beq, lb, ub, nonlcon, option);

% plot
figure,plot(freq,exp([x0,pks_up])); legend({'Pks real','Pks fit'});