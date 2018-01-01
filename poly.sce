getd lib 

x=0:0.01:50;

for i=1:size(x,2)
    y(i) = 2.2*x(i) - 0.0365*x(i)*x(i)
end


myfontSize=3
plot(x,y)
cthick(2)
win() 

ccolor("dark blue")  
ylabs("Fraction of poor HHs with negative income (\%)")
xlabs("Vulnerablity of poor HH assets Vp (\%)") 
leg=legend("$h=.1$","$h=0.25$","$h=0.5$","$h=0.75$","$h=1$",2)
a=gca()
a.y_label.font_size=4



