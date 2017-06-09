function traj = track_spurious(traj,threshold,ovlapSize)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% this function correct spurious vector across the whole movie. 
% threshold is unknown in the beginning. use 200 for testing and fine tune 

for t = 1:size(traj,2)
    [traj(t).res,traj(t).velocitymap]=spurious(traj(t).res,threshold,ovlapSize);
    % save(filename);
    disp(t)
end

