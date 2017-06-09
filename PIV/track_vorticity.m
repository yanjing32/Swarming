function traj = track_vorticity(traj)

% simply track vorticity across the movie

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

for t=1:size(traj,2)
    traj(t).vorticitymap=vorticity(traj(t).velocitymap);
    disp(t)
end



