
getd lib
clf
 
x=0:.1:12;
for i=1:size(x,2)
    y(i) = 1/(1+exp(5-x(i)))+0.05*x(i);
    y2(i) = (1/(1+exp(5-10))+0.05*10)/10*x(i);
end
 
plot(x,y)
cthick(2)
plot(x,y2)
ccolor("dark blue") 
cthick(2)

pensize = 2 
myfontSize=5
ylabs("Wealth at time t+1")
xlabs("Wealth at time t")

a=gca();
a.sub_ticks(2)=0;
a.sub_ticks(1)=0;


//xticks
x_ineterests=  find(abs(y-y2)<0.005);
hop = a.x_ticks;
hop.locations = x(x_ineterests);
hop.labels = emptystr(hop.locations);
a.x_ticks = hop;

//yticks
hop = a.y_ticks;
hop.locations = [];
hop.labels = emptystr(hop.locations);
a.y_ticks = hop;

//size
a.box = "off";
f=gcf();
f.axes_size=[600,450];

xs2png(0,"trap.png")
xs2pdf(0,"trap.pdf")
