% Function Name: find_pairs_cong
% This function is base on *find_pairs.m* written by Jing Yan.
%
% This function finds pairs in an image. If they are too close
% (<lower_threshold, usually 30), then they are likely to be permanantly
% linked dimer.
% 
% INPUT:  (1) "traj"
% 
% OUTPUT: "pairs" 
%
% Written by Cong Xu, 05/17/2014
% Steve Granick Group, MatSE, University of Illinois at Urbana-Champaign
% Last modified by Cong Xu on 05/17/2014


function traj = find_pairs_cong(traj,lower_threshold,upper_threshold)


for t = 1:size(traj,2)
    
    pairs = delaunaynSegs(traj(t).ftr(:,1:2));
    vectpair = traj(t).ftr(pairs(:,2),1:2)-traj(t).ftr(pairs(:,1),1:2);
    dist = sqrt(sum(vectpair.^2,2));
    keep = (dist<upper_threshold & dist>lower_threshold);
    vectpair = vectpair(keep,:);
    traj(t).pairs = pairs(keep,:);
    % pairs(:,3)=ftr(pairs(:,1),6).*ftr(pairs(:,2),6); % only used for phase
    % separation project
    disp(t)
    if keep == 0
        continue;
    else
        traj(t).pairs(:,4) = dist(keep);
    end 
    
end
