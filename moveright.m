function [NewNode,status] = moveright(CurrentNode)
% CurrentNodenumber= size(CurrentNode,3);
% CurrentNode = [145,14];
x = CurrentNode(1,1);
y = CurrentNode(1,2);

node = [x,y];
[inside_obstacle,onobstacle_boundary] = obstacle_check(node);

if inside_obstacle || onobstacle_boundary || (x == 250)
    NewNode = CurrentNode ;
    status = 0;
else
    x =x +1;
    NewNode = [x,y];
    status = 1;
end


end




