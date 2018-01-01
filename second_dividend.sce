clear

getd lib
getd
clf
 
alpha = 100; // productivity 
mu = 0.3; // decreasing returns on capital
eta = 2 // elasticity of marginal utility

r=0.12 // interest rate 12%
v=.5 // vulnerability 50%
//p=0.01 // probability of a shock
insu = 0

x=0.0:0.01:.50;

for i=1:size(x,2)
    p = x(i);
//    K_eq(i) = max(0,(alpha*mu/(r + v*p))^(1/(1-mu)));
    
//    opt = optimset ( "Display" , "iter" );
    opt = optimset ( "TolX" , 1.e-8, "TolFun" , 1e-8,"MaxIter", 1000, "MaxFunEvals", 1000 );


//    if i==1 then
//        [K_opt(i) fval] = fminsearch(list(exp_util,para),K_eq(i)*.5,opt);
////        [K_opt(i) fval] = fminsearch(exp_util2,10,opt);
//    else
//        [K_opt(i) fval] = fminsearch(list(exp_util,para),K_eq(i)*.5,opt);
////        [K_opt(i) fval] = fminsearch(exp_util2,K_opt(i-1),opt);
//    end
//
        para = [alpha mu r eta p v insu]
        [fval K_opt(i)] = optim(list(to_opt,para),1,imp=2);
        para2 = [alpha mu r 0 p v insu]
        [fval K_eq(i)] = optim(list(to_opt,para2),1,imp=2);

    Y_eq(i) = alpha*K_eq(i)^mu;
    W_eq(i) = Y_eq(i) - r*K_eq(i) - v*p*K_eq(i);
    W_eq_ref(i) = alpha*K_eq(1)^mu - r*K_eq(1) - v*p*K_eq(1);

    Y_opt(i) = alpha*K_opt(i)^mu;
    W_opt(i) = Y_opt(i) - r*K_opt(i) - v*p*K_opt(i);
    W_opt_ref(i) = alpha*K_opt(1)^mu - r*K_opt(1) - insu*p*v*K_opt(1) - (1-insu)*v*p*K_eq(1);
    
    
end

//plot(x,[W_opt W_eq K_opt K_eq])
plot(x,[W_opt W_eq])
//plot(x,[W_eq-W_eq_ref])
myfontSize=3;
pensize = 2 ;
ylabs("optimal k and c (in percent of the no-risk situation)");
xlabs("Flood probability");
a=gca();
//a.sub_ticks(2)=0;
//a.sub_ticks(1)=0;
//size
a.box = "off";
f=gcf();
f.axes_size=[600,450];
xs2png(0,"trap.png")
xs2pdf(0,"trap.pdf")



