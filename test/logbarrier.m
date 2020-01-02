% test log barrier method
clean;
% Problem parameters
m = 100; n = 50;
ALPHA = .1; BETA = .7;
mu = 50;
A = randn(m,n);
b = 1 + abs(randn(m,1));
c = randn(n,1);
x = zeros(n,1);
t = 1;
histobj=[];
NTTOL = 1e-10; % stop inner iteration if lambda^2/2 < NTTOL
MAXITERS = 500;
while (t <= 1e8) % Outer loop
niter = 0;
for k=1:MAXITERS % Inner loop
[val,g,H] = objective_barrier(t,x,A,b,c);
v = -H\g; % Newton step
lambda = g'*v; % Newton decrement
% Perform backtracking line search along search direction
s = 1;
while (min([b - A*(x+s*v) ]) < 0)
s = BETA*s;
end % first get feasible point ... then search minimum
while (objective_barrier(t,x+s*v,A,b,c) > val + ALPHA*s*lambda)
s = BETA*s;
end
x = x+s*v;
niter = niter + 1;
% Test if optimum achieved
if (abs(lambda/2) < NTTOL) % decrement smaller than NTTOL?
break;
end
end
% Display progress
obj = c'*x;
histobj=[[histobj],[obj;niter;m/t]]; % Bookkeeeping
disp(['obj: ',num2str(obj,'%1.6e'),'; PDGap: ', num2str(m/t,'%1.2e'), ';number iterations: ',int2str(niter)]);
% Update
t = mu*t;
end

% plot results
PDgap = histobj(3,:); niter = histobj(2,:);
total_iter = cumsum(niter);
figure; semilogy(total_iter,PDgap,'*');