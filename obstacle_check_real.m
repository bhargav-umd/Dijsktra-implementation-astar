function [inside_obstacle, onworkspace_boundry,onobstacle_boundary] = obstacle_check(node)

xc = node(1);
yc = node(2);

% xc = 145;yc=14;

%% Check if inside circle
xcentre=180;
ycentre = 120;
t = 0:0.01:2*pi;
xcircle = 15*cos(t)+ xcentre;
ycircle = 15*sin(t) + ycentre;

[inc,onc] = inpolygon(xc,yc,xcircle,ycircle);

%% Check if inside two polygons 
%rectangle
xp1 = [ 55,105,105,55,55];
yp1 = [ 67.5,67.5,112.5,112.5,67.5] ;

[inp1,onp1] = inpolygon(xc,yc,xp1,yp1);

%polygon
xp2 = [145,168,188,165,158,120,145];
yp2 = [14,14,51,89,51,55,14];
[inp2,onp2] = inpolygon(xc,yc,xp2,yp2);

% workspace
xp3 = [0 ,250, 250, 0 ,0];
yp3 = [0 ,0, 150 ,150 ,0];

[inp3,onp3] = inpolygon(xc,yc,xp3,yp3);

in = inc | inp1 | inp2 | (~inp3);
on = onc | onp1 | onp2;
onobstacle_boundary = on;

inside_obstacle = in;
onworkspace_boundry = onp3;

end