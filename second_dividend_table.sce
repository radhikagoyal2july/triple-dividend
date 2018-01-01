clear
getd lib
getd
clf
 
alpha = 10; // productivity 
mu = 0.3; // decreasing returns on capital
eta = 1.5 // elasticity of marginal utility
r=0.08 // interest rate 8%
v=.25 // vulnerability 25%
pref = 0.1 // probab 
insu = 0 // insurance

opt = optimset ( "TolX" , 1.e-8, "TolFun" , 1e-8,"MaxIter", 1000, "MaxFunEvals", 1000 );

Yref= 100
insuref = 0

// LOOP ON PROBA
//    x=0.0:0.0005:.03;
//    x=0.0:0.001:0.06;
      x=0.0:0.001:0.015
      y=0.02:0.005:0.05
      z=0.06:0.01:0.12
      k=0
      for j=1:size(x,2)
        k=k+1
        p_loop(k)=x(j)
      end
      for j=1:size(y,2)
        k=k+1
        p_loop(k)=y(j)
      end
      for j=1:size(z,2)
        k=k+1
        p_loop(k)=z(j)
    end
    p_loop=p_loop';
    iref = 28;
// LOOP ON VULNERABILITY
      v_loop= [0.25];
      v_ref = 1
// LOOP ON INSUR
      insu_loop = [insu, 1.0];
      insu_ref = 1
// LOOP ON ETA
      eta_loop = [0 eta]
// LOOP ON R
      r_loop = [0.04 0.08 0.12]


para = [alpha mu r eta pref v insuref];
[Kref, fval , flagexit] = fminsearch(list(exp_util,para),100,opt)
Wref = alpha*Kref^mu - r*Kref - v*pref*Kref;
K_opt=zeros(size(r_loop,2),size(eta_loop,2),size(insu_loop,2),size(v_loop,2),size(p_loop,2))
K_eq=ones(K_opt)
Y_eq=zeros(K_opt)
W_eq=zeros(K_opt)
Y_opt=zeros(K_opt)
W_opt=zeros(K_opt)

for j1=1:size(r_loop,2)
    r=r_loop(j1);
    for j2=1:size(eta_loop,2)
        eta=eta_loop(j2); 
        for j=1:size(insu_loop,2)
            insu = insu_loop(j)
            for l=1:size(v_loop,2)
                v = v_loop(l);
                for i=1:size(p_loop,2)
                    p = p_loop(i);

                    para = [alpha mu r eta p v insu];
                    [K_opt(j1,j2,j,l,i), fval , flagexit] = fminsearch(list(exp_util,para),10,opt);
                    para2 = [alpha mu r 0 p v insu];
                    [K_eq(j1,j2,j,l,i), fval , flagexit2] = fminsearch(list(exp_util,para2),10,opt);
                    Y_eq(j1,j2,j,l,i) = alpha*K_eq(j1,j2,j,l,i)^mu;
                    W_eq(j1,j2,j,l,i) = Y_eq(j1,j2,j,l,i) - r*K_eq(j1,j2,j,l,i) - v*p*K_eq(j1,j2,j,l,i);

                    Y_opt(j1,j2,j,l,i) = alpha*K_opt(j1,j2,j,l,i)^mu;
                    W_opt(j1,j2,j,l,i) = Y_opt(j1,j2,j,l,i) - r*K_opt(j1,j2,j,l,i) - v*p*K_opt(j1,j2,j,l,i);

                    W_eq_ref(j1,j2,j,l,i) = alpha*Kref^mu - r*Kref - p*v*Kref;
                    
                    ExpW_opt(j1,j2,j,l,i)=exp_util(K_opt(j1,j2,j,l,i),para);
                    ExpW_eq(j1,j2,j,l,i)=exp_util(K_eq(j1,j2,j,l,i),para);
                    ExpW_eq_ref(j1,j2,j,l,i)=exp_util(Kref,para);
                    
                    disp([v insu p K_opt(j1,j2,j,l,i) K_eq(j1,j2,j,l,i) flagexit flagexit2])          
                end                   
            end            
        end    
    end     
end

k=0
for j1=1:size(r_loop,2)
    r=r_loop(j1);
    for j2=1:size(eta_loop,2)
        eta=eta_loop(j2); 
        for j=1:size(insu_loop,2)
            insu = insu_loop(j);
            for l=1:size(v_loop,2)
                v=v_loop(l);
                for i=1:size(p_loop,2) 
                    
                    W_eq2(j1,j2,j,l,i)=W_eq(j1,j2,j,l,i)/W_eq(j1,j2,insu_ref,v_ref,iref)
                    W_eq_ref2(j1,j2,j,l,i)=W_eq_ref(j1,j2,j,l,i)/W_eq_ref(j1,j2,insu_ref,v_ref,iref)
                    W_opt2(j1,j2,j,l,i)=W_opt(j1,j2,j,l,i)/W_opt(j1,j2,insu_ref,v_ref,iref)

                    ExpW_eq2(j1,j2,j,l,i)=ExpW_eq(j1,j2,j,l,i)/ExpW_eq(j1,j2,insu_ref,v_ref,iref)
                    ExpW_eq_ref2(j1,j2,j,l,i)=ExpW_eq_ref(j1,j2,j,l,i)/ExpW_eq_ref(j1,j2,insu_ref,v_ref,iref)
                    ExpW_opt2(j1,j2,j,l,i)=ExpW_opt(j1,j2,j,l,i)/ExpW_opt(j1,j2,insu_ref,v_ref,iref)                                    
                    k=k+1;
                    p=p_loop(i);
                    T2(k,1)=k
                    T2(k,2)=r;
                    T2(k,3)=eta;
                    T2(k,4)=insu;
                    T2(k,5)=v;
                    T2(k,6)=p;
                    T2(k,7)=K_eq(j1,j2,j,l,i);
                    T2(k,8)=K_opt(j1,j2,j,l,i);
                    T2(k,9)=K_eq(j1,j2,j,l,iref);
                    T2(k,10)=W_eq(j1,j2,j,l,i);
                    T2(k,11)=W_opt(j1,j2,j,l,i);
                    T2(k,12)=W_eq_ref(j1,j2,j,l,i);
                    T2(k,13)=W_eq2(j1,j2,j,l,i);
                    T2(k,14)=W_opt2(j1,j2,j,l,i);
                    T2(k,15)=W_eq_ref2(j1,j2,j,l,i);
                    T2(k,16)=ExpW_eq2(j1,j2,j,l,i);
                    T2(k,17)=ExpW_opt2(j1,j2,j,l,i);
                    T2(k,18)=ExpW_eq_ref2(j1,j2,j,l,i);
                end         
            end
        end        
    end
end
csvWrite(T2,"T_all.csv")



