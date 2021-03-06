tic
clear all;
close all;
%% Define all the obstacles areawise
%plot circle
xcentre=180;
ycentre = 120;
t = 0:0.01:2*pi;
x = 15*cos(t)+ xcentre;
y = 15*sin(t) + ycentre;
drawnow
plot(x,y), hold on
fill(x,y,'r');

%%plot two polygons
xp1 = [ 55,105,105,55,55];
yp1 = [ 67.5,67.5,112.5,112.5,67.5] ;
drawnow
plot(xp1,yp1);
fill(xp1,yp1,'b');

xp2 = [145,168,188,165,158,120,145];
yp2 = [14,14,51,89,51,55,14];
drawnow
plot(xp2,yp2);
fill(xp2,yp2,'r');

xp3 = [0 ,250, 250, 0 ,0];
yp3 = [0 ,0, 150 ,150 ,0];
drawnow
plot(xp3,yp3);
alpha(0.3);
% hold off

%% Get Start and Target points

% start_node = [xg,yg];
% target_node = [xt,yt];
[start_node,target_node] = Takeinput_fromuser();
% start_node =[0,0];
% target_node =[250,150];

%% %% Check if user input points are inside obstacles or in workspace
[inside_obstacle, onobstacle_boundary] = obstacle_check(start_node);
if inside_obstacle || onobstacle_boundary
    say = 'Starting point is not in Free workspace';
    disp(say)
    return
end

[inside_obstacle,onobstacle_boundary] = obstacle_check(target_node);
if inside_obstacle || onobstacle_boundary
    
    say = 'Target point is not in workspace, cannot be reached' ;
    disp(say)
    return
    
end

drawnow
plot(start_node(1),start_node(2),'*');
plot(start_node(1),start_node(2),'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b');

% target_node =[106,120];
drawnow
plot(target_node(1),target_node(2),'*');
plot(target_node(1),target_node(2),'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','g' );


%% Intializing nodes
NodesSet = [];%saves unique nodes, visited nodes
NodesInfoSet = [];% NodeInfor = [N,ParentNodeNumber,costtocome];

CurrentNode= start_node;
NodesSet(:,:,1) = CurrentNode;
CurrentNodenumber=size(CurrentNode,3);
id = getid(CurrentNode);
ParentNodeNumber =1 ;
costtocome= 0;
N = 1; % Number of visited Nodes
CurrentNode = NodesSet(:,:,ParentNodeNumber);
cost_linear = 1;
cost_diagonal =sqrt(2);
hcost=norm(target_node - CurrentNode);
tcost = costtocome+ hcost;
NodesInfoSet(:,:,1)=[1,1,costtocome,tcost,id];
%% USE BFS for Creating Nodes for all points until target is reached
while ~isequal(CurrentNode,target_node)
    
    % NodeInfo(:,:,N) = [N,ParentNodeNumber,costtocome];
    CurrentNode = NodesSet(:,:,ParentNodeNumber);
    %%  For Right
    
    [NewNode,status] = moveright(CurrentNode);
    if (status == 1)
        [inside_obstacle,onobstacle_boundary] = obstacle_check(NewNode);
        if ~(inside_obstacle || onobstacle_boundary)
         
            id_test = getid(NewNode);
            if(~any(id_test == NodesInfoSet(1,5,:)))
                N=N+1;
                NodesSet(:,:,N)=NewNode;
                costtocome = cost_linear + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode) ;
                id = getid(NewNode);
                NodesInfoSet(:,:,N) = [N,ParentNodeNumber,costtocome,tcost,id];
            else
                costtocome = cost_linear + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode);
                id_index = find(id_test == NodesInfoSet(1,5,:));
                pt =NodesInfoSet(1,2,id_index);
                tt =NodesInfoSet(1,4,id_index);
                ct = NodesInfoSet(1,3,id_index);
                if (tt < tcost)
                    parent_temp = pt;
                    min_t_cost = tt;
                    min_cost = ct;
                else
                    parent_temp = ParentNodeNumber;
                    min_t_cost =tcost ;
                    min_cost = costtocome;
                end
                NodesInfoSet(:,:,id_index) = [id_index,parent_temp,min_cost,min_t_cost,id_test] ;
            end
         
        end
    end
    
    %% For Up Right
    [NewNode,status] = moveupright(CurrentNode);
    if (status == 1)
        [inside_obstacle,onobstacle_boundary] = obstacle_check(NewNode);
        if ~(inside_obstacle || onobstacle_boundary)
  
            
            id_test = getid(NewNode);
            if(~any(id_test == NodesInfoSet(1,5,:)))
                N=N+1;
                NodesSet(:,:,N)=NewNode;
                costtocome = cost_diagonal + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode) ;
                id = getid(NewNode);
                NodesInfoSet(:,:,N) = [N,ParentNodeNumber,costtocome,tcost,id];
            else
                costtocome = cost_diagonal + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode);
                id_index = find(id_test == NodesInfoSet(1,5,:));
                pt =NodesInfoSet(1,2,id_index);
                tt =NodesInfoSet(1,4,id_index);
                ct = NodesInfoSet(1,3,id_index);
                if (tt < tcost)
                    parent_temp = pt;
                    min_t_cost = tt;
                    min_cost = ct;
                else
                    parent_temp = ParentNodeNumber;
                    min_t_cost =tcost ;
                    min_cost = costtocome;
                end
                NodesInfoSet(:,:,id_index) = [id_index,parent_temp,min_cost,min_t_cost,id_test] ;
            end
        end
    end
    
    %% For Up
    [NewNode,status] = moveup(CurrentNode);
    if (status == 1)
        [inside_obstacle,onobstacle_boundary] = obstacle_check(NewNode);
        if ~(inside_obstacle || onobstacle_boundary)
            
            id_test = getid(NewNode);
            if(~any(id_test == NodesInfoSet(1,5,:)))
                N=N+1;
                NodesSet(:,:,N)=NewNode;
                costtocome = cost_linear + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode) ;
                id = getid(NewNode);
                NodesInfoSet(:,:,N) = [N,ParentNodeNumber,costtocome,tcost,id];
            else
                costtocome = cost_linear + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode);
                id_index = find(id_test == NodesInfoSet(1,5,:));
                pt =NodesInfoSet(1,2,id_index);
                tt =NodesInfoSet(1,4,id_index);
                ct = NodesInfoSet(1,3,id_index);
                if (tt < tcost)
                    parent_temp = pt;
                    min_t_cost = tt;
                    min_cost = ct;
                else
                    parent_temp = ParentNodeNumber;
                    min_t_cost =tcost ;
                    min_cost = costtocome;
                end
                NodesInfoSet(:,:,id_index) = [id_index,parent_temp,min_cost,min_t_cost,id_test] ;
            end
        end
    end
    
    %% For Up Left
    [NewNode,status] = moveupleft(CurrentNode);
    if (status == 1)
        [inside_obstacle,onobstacle_boundary] = obstacle_check(NewNode);
        if ~(inside_obstacle || onobstacle_boundary)
            
            id_test = getid(NewNode);
           if(~any(id_test == NodesInfoSet(1,5,:)))
                N=N+1;
                NodesSet(:,:,N)=NewNode;
                costtocome = cost_diagonal + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode) ;
                id = getid(NewNode);
                NodesInfoSet(:,:,N) = [N,ParentNodeNumber,costtocome,tcost,id];
            else
                costtocome = cost_diagonal + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode);
                id_index = find(id_test == NodesInfoSet(1,5,:));
                pt =NodesInfoSet(1,2,id_index);
                tt =NodesInfoSet(1,4,id_index);
                ct = NodesInfoSet(1,3,id_index);
                if (tt < tcost)
                    parent_temp = pt;
                    min_t_cost = tt;
                    min_cost = ct;
                else
                    parent_temp = ParentNodeNumber;
                    min_t_cost =tcost ;
                    min_cost = costtocome;
                end
                NodesInfoSet(:,:,id_index) = [id_index,parent_temp,min_cost,min_t_cost,id_test] ;
           end
        end
    end
    %% For left
    [NewNode,status] = moveleft(CurrentNode);
    if (status == 1)
        [inside_obstacle,onobstacle_boundary] = obstacle_check(NewNode);
        if ~(inside_obstacle || onobstacle_boundary)
            
            id_test = getid(NewNode);
            if(~any(id_test == NodesInfoSet(1,5,:)))
                N=N+1;
                NodesSet(:,:,N)=NewNode;
                costtocome = cost_linear + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode) ;
                id = getid(NewNode);
                NodesInfoSet(:,:,N) = [N,ParentNodeNumber,costtocome,tcost,id];
            else
                costtocome = cost_linear + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode);
                id_index = find(id_test == NodesInfoSet(1,5,:));
                pt =NodesInfoSet(1,2,id_index);
                tt =NodesInfoSet(1,4,id_index);
                ct = NodesInfoSet(1,3,id_index);
                if (tt < tcost)
                    parent_temp = pt;
                    min_t_cost = tt;
                    min_cost = ct;
                else
                    parent_temp = ParentNodeNumber;
                    min_t_cost =tcost ;
                    min_cost = costtocome;
                end
                NodesInfoSet(:,:,id_index) = [id_index,parent_temp,min_cost,min_t_cost,id_test] ;
            end
        end
    end
    
    %% For Down Left
    [NewNode,status] = movedownleft(CurrentNode);
    if (status == 1)
        [inside_obstacle,onobstacle_boundary] = obstacle_check(NewNode);
        if ~(inside_obstacle || onobstacle_boundary)

            id_test = getid(NewNode);
           if(~any(id_test == NodesInfoSet(1,5,:)))
                N=N+1;
                NodesSet(:,:,N)=NewNode;
                costtocome = cost_diagonal + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode) ;
                id = getid(NewNode);
                NodesInfoSet(:,:,N) = [N,ParentNodeNumber,costtocome,tcost,id];
            else
                costtocome = cost_diagonal + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode);
                id_index = find(id_test == NodesInfoSet(1,5,:));
                pt =NodesInfoSet(1,2,id_index);
                tt =NodesInfoSet(1,4,id_index);
                ct = NodesInfoSet(1,3,id_index);
                if (tt < tcost)
                    parent_temp = pt;
                    min_t_cost = tt;
                    min_cost = ct;
                else
                    parent_temp = ParentNodeNumber;
                    min_t_cost =tcost ;
                    min_cost = costtocome;
                end
                NodesInfoSet(:,:,id_index) = [id_index,parent_temp,min_cost,min_t_cost,id_test] ;
            end
        end
    end
    %% For down
    [NewNode,status] = movedown(CurrentNode);
    if (status == 1)
        [inside_obstacle,onobstacle_boundary] = obstacle_check(NewNode);
        if ~(inside_obstacle || onobstacle_boundary)
            
            id_test = getid(NewNode);
           if(~any(id_test == NodesInfoSet(1,5,:)))
                N=N+1;
                NodesSet(:,:,N)=NewNode;
                costtocome = cost_linear + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode) ;
                id = getid(NewNode);
                NodesInfoSet(:,:,N) = [N,ParentNodeNumber,costtocome,tcost,id];
            else
                costtocome = cost_linear + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode);
                id_index = find(id_test == NodesInfoSet(1,5,:));
                pt =NodesInfoSet(1,2,id_index);
                tt =NodesInfoSet(1,4,id_index);
                ct = NodesInfoSet(1,3,id_index);
                if (tt < tcost)
                    parent_temp = pt;
                    min_t_cost = tt;
                    min_cost = ct;
                else
                    parent_temp = ParentNodeNumber;
                    min_t_cost =tcost ;
                    min_cost = costtocome;
                end
                NodesInfoSet(:,:,id_index) = [id_index,parent_temp,min_cost,min_t_cost,id_test] ;
            end
        end
    end
    
    %% For DownRight
    [NewNode,status] = movedownright(CurrentNode);
    if (status == 1)
        [inside_obstacle,onobstacle_boundary] = obstacle_check(NewNode);
        if ~(inside_obstacle || onobstacle_boundary)
            
            id_test = getid(NewNode);
            if(~any(id_test == NodesInfoSet(1,5,:)))
                N=N+1;
                NodesSet(:,:,N)=NewNode;
                costtocome = cost_diagonal+ NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode) ;
                id = getid(NewNode);
                NodesInfoSet(:,:,N) = [N,ParentNodeNumber,costtocome,tcost,id];
            else
                costtocome = cost_diagonal + NodesInfoSet(1,3,ParentNodeNumber);
                tcost = costtocome + norm(target_node - NewNode);
                id_index = find(id_test == NodesInfoSet(1,5,:));
                pt =NodesInfoSet(1,2,id_index);
                tt =NodesInfoSet(1,4,id_index);
                ct = NodesInfoSet(1,3,id_index);
                if (tt < tcost)
                    parent_temp = pt;
                    min_t_cost = tt;
                    min_cost = ct;
                else
                    parent_temp = ParentNodeNumber;
                    min_t_cost =tcost ;
                    min_cost = costtocome;
                end
                NodesInfoSet(:,:,id_index) = [id_index,parent_temp,min_cost,min_t_cost,id_test] ;
            end
        end
    end
    
    ParentNodeNumber = ParentNodeNumber+1;
    
    
    
end
%% Backtracking the nodes to plot the optimal path found
ParentNodeNumber = ParentNodeNumber - 1;
i=2;path(:,:,1) = CurrentNode;
Number = ParentNodeNumber;
TrackInfo =[];
TrackInfo(:,:,1)= [1,Number];
while  ~isequal(CurrentNode,start_node)
    
    
    P = NodesInfoSet(1,2,Number);
    CurrentNode = NodesSet(:,:,P);
    path(:,:,i) = NodesSet(:,:,P);
    %      NodesSet(:,:,Number);
    TrackInfo(:,:,i)= [Number,P];
    Number = NodesInfoSet(1,2,P);
    i = i+1;
    %      NodesSet(:,:,Number);
    
end
%% plot the optimal path
for u = 1:i-1
    Pathx(u) = path(1,1,u);
    Pathy(u) = path(1,2,u);
end

drawnow
plot(Pathx,Pathy,'linewidth',2);
hold off
toc

