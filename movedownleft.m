function [NewNode,status] = movedownleft(CurrentNode)
% CurrentNodenumber= size(CurrentNode,3);
% CurrentNode = [143,14];
x = CurrentNode(1,1);
y = CurrentNode(1,2);

node = [x,y];
[inside_obstacle,onobstacle_boundary] = obstacle_check(node);

if inside_obstacle || onobstacle_boundary || (x==0) || (y ==0) 
    NewNode = CurrentNode ;
    status = 0;
else
    x = x-1;
    y = y-1;
    NewNode = [x,y];
    status = 1;
end


end




