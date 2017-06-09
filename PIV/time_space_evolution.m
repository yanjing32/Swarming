function tsmatrix = time_space_evolution(traj,rot,time_range,space_range_vert,space_range_hor)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% this function is used to make the time-space plot for figure. 

tsmatrix = zeros(size(space_range_vert,2).*size(time_range,2),size(space_range_hor,2));

for t = time_range
    
    densitymap = traj(t).densitymap;
    densitymap_rotate = imrotate(densitymap,rot);
    densitymap_rotate = densitymap_rotate(space_range_vert,space_range_hor);
    tsmatrix((t-1)*size(space_range_vert,2)+1:t*size(space_range_vert,2),:) = densitymap_rotate;
end




