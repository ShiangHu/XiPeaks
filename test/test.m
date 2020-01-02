clean;
options = optimoptions(@fmincon,'display','iter');
options.MaxFunctionEvaluations = 1e5;
options.MaxIterations = 2e3;
options.OptimalityTolerance = 1e-015;
options.StepTolerance = 1e-015;
options.SpecifyObjectiveGradient=true;

lmd = 1e3;

f = linspace(0.01,80,204);
x = 100*normpdf(f,40,5)';

psd_x0 = log(x);
lb = log(x) -5; 
ub = log(x) + 5;

nf = length(f);

C = diff(eye(nf),3); 

C = sparse(C'*C); 

D = sparse(diff(eye(nf),2)); b = zeros(202,1);

psd_unim= fmincon(@(n)uniobj(n,x,lmd,C),psd_x0,D,b,[],[],lb,ub,[],options);