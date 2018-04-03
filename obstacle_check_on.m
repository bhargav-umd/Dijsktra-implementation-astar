function [inside_obstacle, onworkspace_boundry,onobstacle_boundary]=obstacle_check(xc,yc)
%% Check if inside circle
xcentre=180;
ycentre = 120;
% t = 0:0.01:2*pi;
% xcircle = 15*cos(t)+ xcentre;
% ycircle = 15*sin(t) + ycentre;

pc = (xc - xcentre)^2 + (yc  -ycentre)^2 -225;
if pc < 0 
    inc = true;
    onc = false;
    outc = false;
elseif pc == 0 
    onc =true;
     inc = false;
    outc = false;
else 
    onc = false;
    inc =false;
    outc =true;
end
%% splitting all polygon into lines to represent them with half plane 
% rectangle lines 

%line 1
p1 = xc -55 ;
if p1 > 0 
    in1 = true;
    on1 = false;
    out1 = false;
elseif p1 == 0
    on1 = true;
    in1 = false;
    out1 = false;
else
    in1 =false;
    out1 =true;
    on1 = false;
end
%line 2 

p2 = yc -112.5;
if p2 < 0 
    in2 = true;
    on2 = false;
    out2 =false;
elseif p2 == 0
    on2 = true;
    in2 =false;
    out2 =false;
else
    in2 =false;
    out2 =true;
    on2 = false;
end

%line 3
p3 = xc - 105;
if p3 < 0 
    in3 = true;
    on3 = false;
    out3 =false;
elseif p3 == 0
    on3 = true;
     in3 =false;
    out3 =false;
else
    on3 = false;
    in3 =false;
    out3 =true;
end

%line4
p4 = yc -67.5;
if p5 > 0 
    in4 = true;
    on4 = false;
    out4 =false;
elseif p4 == 0
    on4 = true;
    in4 =false;
    out4 =false;
else
    on4 = false;
    in4 =false;
    out4 =true;
end


%divinding polygon into 6 line segments
%line5

p5 = yc + 41 * (xc) /25 -1259/5;
if p5 < 0 
    in5 = true;
    on5 = false;
    out5 =false;
elseif p5 ==0
    on5 = true;
    in5 =false;
    out5 =false;
else
    on5 = false;
    in5 =false;
    out5 =true;
end


%line6
p6 = yc + 2*(xc) / 19 -1285/19;
if p6 < 0 
    in6 = true;
    on6 = false;
    out6 =false;
elseif p6 == 0
    on6 = true;
    in6 =false;
    out6 =false;
else
    on6 = false;
    in6 =false;
    out6 =true;
end

%line 7

p7 = yc - (38/7)* xc + 5647/7 ;
if p7 > 0 
    in7 = true;
    on7 = false;
    out7 =false;
elseif p7 == 0
    on7 = true;
    in7 =false;
    out7 =false;
else
    in7 =false;
    out7 =true;
    on7 = false;
end

%line 8 
p8 = yc + 38/23 * (xc) -8317/23 ;
if p8 < 0 
    in8 = true;
    on8 = false;
     out8 =false;
elseif p8 == 0
    on8 = true;
    in8 =false;
    out8 =false;
else
    in8 =false;
    out8 =true;
    on8 = false;
end
%line 9 
p9 = yc -37/20 * (xc) + 1484/5;
if p9 > 0 
    in9 = true;
    on8 = false;
    out9 =false;
elseif p9 == 0
    on9 = true;
    in9 =false;
    out9 =false;
else
    in9 =false;
    out9 =true;
    on9 = false;
end

%Line 10
p10 = yc -14;

if p10 > 0 
    in10 = true;
    on10 = false;
      out10 =false;
elseif p10 == 0
    on10 = true;
    in10 =false;
    out10 =false;
else
    on10 = false;
    in10 =false;
    out10 =true;
end


%%drawing 2 lines to split our polygon into 3 concave polygons (2 triangle
%%and 1 quadrilateral.

%line 12 (158,51)and (145 14)
p12 = yc -37*xc /13 + 5183/13;
if p12 > 0 
    inp12t1 = true;
     inp12q1 =false;
    outp12t1 =false;
else
    inp12t1 =false;
    outp12t1 =true;
    inp12t1 = false;
end

if p12 < 0 
    inp12q1 = true;
    inp12q1 =true;
    outp12q1 =false;
else
     inp12q1 = false;
    inp12q1 =false;
    outp12q1 =true;
end

%for line 13 y =51
p13 = yc -51;
if p13 > 0 
    inp13t2 = true;
    inp13q1 =false;
    outp13q1 =true;
    
     intp132 =true;
    outp13t2 =false;
    inp13q1 =false;
else
    intp132 =false;
    outp13t2 =true;
    inp13q1 =true;
    
     inp13t2 = false;
    inp13q1 =true;
    outp13q1 =false;
end

%% on workspace 
%left boundary yaxis
plb = xc;
if plb > 0 
    inlb = true;
    onlb = false;
    outlb =false;
elseif plb == 0
    onlb = true;
    inlb =false;
    outlb =false;
else
    inlb =false;
    outlb =true;
    onlb = false;
end

%on bottom boundary of workspace
pbb = yc;
if pbb > 0 
    inbb = true;
    onbb= false;
    outbb=false;
elseif pbb == 0
    onbb = true;
    inbb =false;
    outbb =false;
else
    inbb =false;
    outbb =true;
    onbb = false;
end

%top boundary
ptb = yc -150;
if ptb < 0 
    intb = true;
    ontb= false;
    outtb=false;
elseif ptb == 0
    ontb = true;
    intb =false;
    outtb =false;
else
    intb =false;
    outtb =true;
    ontb = false;
end


%% checking for rectangle,t1,t2,q1 based line 1,2,3,4
inr = in1 & in2 & in3 & in4;
int1 = in5 & in6 & intp12t1; 
int2 = in7 & in8 & inp13t2;
inq1 = in10 & in9 & inp12q1 & inp13q1 ;

inwk = inlb & inrb & inbb & intb ;

in = inr | inc | int1 | int2 | inq1 | (~inwk);
inside_obstacle = in;

%% on obstacle 
on = onc | on1 | on2 | on3 | on4 |on5 | on6 | on7 | on8 | on9 | on10;
onobstacle_boundary =on;

%% outside 
onworkspace_boundry = inwk;






