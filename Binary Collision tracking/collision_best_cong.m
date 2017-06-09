% Function Name: collision_best_cong
% 
% This function aims to: 
% (1) find particle pairs that last for at least 5 consecutive frames
% (2) exclude particles that are stuck to the substrate
% 
% INPUT:  variable "collisions" from *collision_property_cong.m* (black/white)
% 
% OUTPUT: "index": index of collisions in variable "collisions"
%
% Written by Cong Xu, 10/22/2013
% Steve Granick Group, MatSE, University of Illinois at Urbana-Champaign
% Last modified by Cong Xu on 11/03/2013

function index = collision_best_cong(collisions)

% % % FIND LONG-LIVED PARTICLE PAIRS
col_length = zeros(size(collisions,2),1);

for t = 1:size(collisions,2)
    col_length(t)=size(collisions(t).ftr,1);
end

keep = col_length>5;  % keep is the minimum "length" of the "follow" event
% if col_length>5, then keep=1, else keep=0
% the output of keep is a N*1 array

ind = find(keep==1);
% 'ind' is the index of particles whose 'keep' equals 1



% % % DELETE STUCK PARTICLES
count=0; % use 'count' to count the total number of good particle pairs
index=zeros(size(ind,1),1);
% use 'index' to store particle pairs that are not stuck to the substrate
% first create size(index,1) dimension array
% then delete all the rest zeros at the end of the for-loop below

for m = 1:size(ind,1)
    
    actual_col = collisions(ind(m)).ftr;
    % 'actual_col' means "actual collisions" with col_length>5
    
    if ((actual_col(1,1)-actual_col(end,1))^2+(actual_col(1,2)-actual_col(end,2))^2 < 50) ||...
       ((actual_col(1,4)-actual_col(end,4))^2+(actual_col(1,5)-actual_col(end,5))^2 < 50) ||...
       ((actual_col(2,1)-actual_col(end-1,1))^2+(actual_col(2,2)-actual_col(end-1,2))^2 < 50) ||...
       ((actual_col(2,4)-actual_col(end-1,4))^2+(actual_col(2,5)-actual_col(end-1,5))^2 < 50)
        continue;
    end
    % exclude particles that are stuck to the substrate
    % if (x1_first-x1_last)^2+(y1_first-y1_last)^2<50, then regard this particle as stuct particle
    
    count=count+1;
    index(count,1)=ind(m);
end

index=index(find(index));
% delete all the unused rows in the "index"
% algorithm x=x(find(x)) can delete all the rest zeros in the x colume-array




