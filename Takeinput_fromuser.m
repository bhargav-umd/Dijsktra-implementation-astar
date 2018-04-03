function [start_node,target_node] = Takeinput_fromuser()

prompt = {'Insert coordinates(x,y) of starting point ',...
              'Insert coordinates(x,y) of Target point '};
default_values = {'0 0','250 150'};
num_lines = 1;
title = 'Start and Target Point Input';

values = inputdlg(prompt,title,num_lines,default_values);
start_node =  str2num(values{1});
target_node = str2num(values{2});



end