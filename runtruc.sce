clear
v=.25
exec('second_dividend_table_v2.sce')
csvWrite(T,"T_25_eta1.5.csv")
v=.125
exec('second_dividend_table_v2.sce')
csvWrite(T,"T_125_eta1.5.csv")

alpha = 10; // productivity 
mu = 0.3; // decreasing returns on capital
eta = 1.5 // elasticity of marginal utility
r=0.08 // interest rate 8%
v=.25 // vulnerability 25%
pref = 0.1 // probab 
insu = 0 // insurance
Yref= 100
insuref = 0

// LOOP ON PROBA
//    x=0.0:0.0005:.03;
//    x=0.0:0.001:0.06;
      p_loop=-0.01:.01:0.12
      p_loop(1)=pref
      iref = 1
// LOOP ON VULNERABILITY
      v_loop= [0.125, 0.2, 0.25, 0.5];
      v_ref = 3
// LOOP ON INSUR
      insu_loop = [insu, 0.25, 0.5];
      insu_ref = 1
// LOOP ON ETA
      eta_loop = [0.5 eta]
// LOOP ON R
      r_loop = [0.04 r 0.12]

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
                        W_eq2(j1,j2,j,l,i)=W_eq(j1,j2,j,l,i)/W_eq(j1,j2,insu_ref,v_ref,iref);
                        W_eq_ref2(j1,j2,j,l,i)=W_eq_ref(j1,j2,j,l,i)/W_eq_ref(j1,j2,insu_ref,v_ref,iref);
                        W_opt2(j1,j2,j,l,i)=W_opt(j1,j2,j,l,i)/W_opt(j1,j2,insu_ref,v_ref,iref);
                end     
                for i=1:size(p_loop,2) 
                    k=k+1;
                    p=p_loop(i);
                    T2(k,1)=r;
                    T2(k,2)=eta;
                    T2(k,3)=insu;
                    T2(k,4)=v;
                    T2(k,5)=p;
                    T2(k,6)=K_eq(j1,j2,j,l,i);
                    T2(k,7)=K_opt(j1,j2,j,l,i);
                    T2(k,8)=K_eq(j1,j2,j,l,iref);
                    T2(k,9)=W_eq(j1,j2,j,l,i);
                    T2(k,10)=W_opt(j1,j2,j,l,i);
                    T2(k,11)=W_eq_ref(j1,j2,j,l,i);
                    T2(k,12)=W_eq2(j1,j2,j,l,i);
                    T2(k,13)=W_opt2(j1,j2,j,l,i);
                    T2(k,14)=W_eq_ref2(j1,j2,j,l,i);
                end         
            end
        end        
    end
end
csvWrite(T2,"truc.csv")

x=-0.001:0.001:0.015
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


