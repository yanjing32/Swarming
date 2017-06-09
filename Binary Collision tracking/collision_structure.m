function [collisions,allpairs]=collision_structure(traj,allpairs)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% try to make all collision into structure structure parameter.

collisions=struct('ftr',[]);

allpairs=[allpairs
    0 0 0];
temp1=allpairs(1,1); % pair 1
temp2=allpairs(1,2); % pair 2

count_all = 1;
count = 1;

for n=1:size(allpairs,1)-1
    if allpairs(n+1,1)==temp1 && allpairs(n+1,2)==temp2
        % now first try to find the two incoming angle 
        ind=find(traj(allpairs(n,3)).id==temp1);
        collisions(count_all).ftr(count,1:3)=traj(allpairs(n,3)).ftr(ind,1:3);
        ind=find(traj(allpairs(n,3)).id==temp2);
        collisions(count_all).ftr(count,4:6)=traj(allpairs(n,3)).ftr(ind,1:3);
        allpairs(n,4)=count_all;
        count = count+1;
    else
         ind=find(traj(allpairs(n,3)).id==temp1);
        collisions(count_all).ftr(count,1:3)=traj(allpairs(n,3)).ftr(ind,1:3);
        ind=find(traj(allpairs(n,3)).id==temp2);
        collisions(count_all).ftr(count,4:6)=traj(allpairs(n,3)).ftr(ind,1:3);
        allpairs(n,4)=count_all;
        count_all = count_all+1;
        count = 1;
        temp1=allpairs(n+1,1); % pair 1
        temp2=allpairs(n+1,2);    
    end
    
end

