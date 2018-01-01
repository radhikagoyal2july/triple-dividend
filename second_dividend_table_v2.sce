//clear
getd lib
getd
clf
 
alpha = 100; // productivity 
alpha_eta = 37.649894  ;
alpha_noeta = 38.347935  ;
mu = 0.3; // decreasing returns on capital
eta = 1.5 // elasticity of marginal utility

r=0.12 // interest rate 12%
//v=.5 // vulnerability 50%
//p=0.01 // probability of a shock
x=0.0:0.001:.20;
insu = 0
insu_t = 0:0.5;
//insu_t = 0.50

opt = optimset ( "TolX" , 1.e-8, "TolFun" , 1e-8,"MaxIter", 1000, "MaxFunEvals", 1000 );

Yref= 100
pref = 0.05
insuref = 0

para = [alpha mu r eta pref v 1.0];
[alpha, fval , flagexit] = fminsearch(list(opti_K,100,para),100,opt);
para(1)= alpha;
[Kref, fval , flagexit] = fminsearch(list(exp_util,para),100,opt)
Wref = alpha_eta*Kref^mu - r*Kref - v*pref*Kref;

disp(alpha_noeta,alpha,Kref,Wref)

for j=1:size(insu_t,2)
    insu = insu_t(j)

    for i=1:size(x,2)
        p = x(i);

        para = [alpha mu r eta p v insu];
        [K_opt(j,i), fval , flagexit] = fminsearch(list(exp_util,para),10,opt);
        para2 = [alpha mu r eta p v 1];
        [K_eq(j,i), fval , flagexit2] = fminsearch(list(exp_util,para2),10,opt);

        disp([insu p K_opt(j,i) K_eq(j,i) flagexit flagexit2])

        Y_eq(j,i) = alpha*K_eq(j,i)^mu;
        W_eq(j,i) = Y_eq(j,i) - r*K_eq(j,i) - v*p*K_eq(j,i);

        Y_opt(j,i) = alpha*K_opt(j,i)^mu;
        W_opt(j,i) = Y_opt(j,i) - r*K_opt(j,i) - v*p*K_opt(j,i);
    
        W_eq_ref(j,i) = alpha_eta*K_opt(j,1)^mu - r*K_opt(j,1) - insu*p*v*K_opt(j,1) - (1-insu)*v*p*K_opt(j,1);    
    end
end

//plot(x,[W_opt W_eq K_opt K_eq])
plot(x,W_opt(1,:))
plot(x,W_eq(1,:))
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


k=0
for j=1:size(insu_t,2)
    insu = insu_t(j);
    for i=1:size(x,2) 
        k=k+1;
        p=x(i);
        T(k,1)=insu;
        T(k,2)=p;
        T(k,3)=K_eq(j,i);
        T(k,4)=K_opt(j,i);
        T(k,5)=K_eq(j,1);
        T(k,6)=W_eq(j,i);
        T(k,7)=W_opt(j,i);
        T(k,8)=W_eq_ref(j,i);
    end
end
csvWrite(T,"T.csv")

