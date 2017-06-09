% Function Name: angle_filter_follow_cong
% 
% This function separates follow (or alignment) events from all the
% 2-particle events.
% 
% INPUT:  (1) "collisions": is the 'input'  of *collision_best_cong.m*
%         (2) "index"     : is the 'output' of *collision_best_cong.m*
%
% OUTPUT: (1) "index_follow":   index follow trajectories in variable "collisions"
% 
% Written by Cong Xu, 05/26/2014
% Steve Granick Group, MatSE, University of Illinois at Urbana-Champaign
% Last modified by Cong Xu on 05/26/2014

function index_follow = angle_filter_follow_cong(collisions,index)

count = 0;
index_follow = zeros(size(index,1),1);

for m = 1:size(index,1)
    
    ftr = collisions(index(m)).ftr;
    
    if ftr(1,11)*ftr(1,12)>0 && abs(ftr(1,11))<abs(ftr(1,12))
        count = count+1;
        index_follow(count,1) = index(m);
    end
end

% delete unused zeros
index_follow = index_follow(find(index_follow));