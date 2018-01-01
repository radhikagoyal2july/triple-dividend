getd lib
clf
 
s = 0.3;
mu = 0.25;
rho = 0.1;
x=0.1:.1:12;
for i=1:size(x,2)
    y(i) = 1/(1-s)*(1+1/(mu*x(i)))/(rho+1/x(i));
    y2(i) = (mu+1/(x(i)))/(rho+1/x(i));
end
 
plot(x,y)
myfontSize=3
cthick(2)
ccolor("dark blue") 
//plot(x,y2)

pensize = 2 
ylabs("Scaling factor (DC/C)/(DK/K)")
//ylabs("Scaling factor (DC/DK)")
xlabs("Characteristic time of the reconstruction period (years)")

a=gca();
//a.sub_ticks(2)=0;
//a.sub_ticks(1)=0;


//size
a.box = "off";
f=gcf();
f.axes_size=[600,450];

xs2png(0,"trap.png")
xs2pdf(0,"trap.pdf")
