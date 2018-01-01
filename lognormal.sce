getd lib 

x=0:0.01:1.2;
x(1)=x(1)+1e-8;
alf = [0.1 0.25 0.5 0.75 0.999999]

y=zeros(size(x,2),size(alf,2));
for j=1:size(alf,2)
H=alf(j);
for i=1:size(x,2)
    y(i,j) = 1/2*(1-erf(-log((1+0)/H*1.*x(i))/(2*sqrt(-log(H)))));
end

end
myfontSize=3
plot(100*x,100*y)
cthick(2)
win() 


ccolor("dark blue")  
ylabs("Fraction of poor HHs with negative income (\%)")
xlabs("Vulnerablity of poor HH assets Vp (\%)") 
leg=legend("$h=.1$","$h=0.25$","$h=0.5$","$h=0.75$","$h=1$",2)
a=gca()
a.y_label.font_size=4



