
function f = exp_util(x,p)
 //   disp("toto")
    k=x;
    if k<=0 then
        k=1e-12;
    end
    alpha=p(1);
    mu=p(2);
    r=p(3);
    eta=p(4);
    proba=p(5);
    vul=p(6);
    insu=p(7);
//    disp("new")
//    disp(k)
//    disp(alpha)
//    disp(mu)
//    disp(r)
//    disp(eta)
//    disp(proba)
//    disp(vul)
//    disp(insu)
//
    prod = alpha*k^mu;
    conso_no = prod - r*k - insu*proba*vul*k;
    conso_with = prod - r*k - insu*proba*vul*k - (1-insu)*vul*k;
    if (eta==0)|(proba==0)|(conso_with>0) then        
        util_no = conso_no^(1-eta)/(1-eta)   ;
        util_with = conso_with^(1-eta)/(1-eta);
    else
        util_no = -1e50
        util_with = -1e50
    end
    f = -1*real(proba*util_with + (1-proba)*util_no);

 
endfunction

function [f, g, ind] = to_opt(x,ind,p)
    if x<=0 then
        x=1e-4;
    end
    f=exp_util(x,p);
    g=(exp_util(x*1.000001,p)-exp_util(x,p))/(0.000001*x);
endfunction


function f = exp_util2(x)

//    disp(x)
    alpha = 10; // productivity 
    mu = 0.3; // decreasing returns on capital
    eta = 2 // elasticity of marginal utility

    r=0.06 // interest rate 6%
    vul=.6 // vulnerability 60%
    proba=0.01 // probability of a shock
    insu = 0
    
    k=x
  
    prod = alpha*k^mu
    conso_no = prod - r*k - insu*proba*vul*k
    conso_with = prod - r*k - insu*proba*vul*k - (1-insu)*vul*k
    util_no = conso_no^(1-eta)/(1-eta)   
    util_with = conso_with^(1-eta)/(1-eta)
    f = real(-1*(proba*util_with + (1-proba)*util_no))
//    disp(f)
endfunction

function f=opti_K(alpha_i,obje,p)
    p(1)=alpha_i;
    mu=p(2);
    r=p(3);
    eta=p(4);
    proba=p(5);
    vul=p(6);
    insu=p(7);
    [Kref, fval , flagexit] = fminsearch(list(exp_util,p),10,opt);
    Wref = alpha_i*Kref^mu - r*Kref - proba*vul*Kref; 
    dist = (obje-Wref)^2;
 //   disp(p)
    f= dist;
endfunction
