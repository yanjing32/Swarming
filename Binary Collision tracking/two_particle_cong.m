% This program aims to:
% (1) find the two particle "follow" events in Janus particles' metal head forward
%     and silica side forward situations;
% (2) plot <probability density> vs <abs('theta_1'-'theta_2')> for the follow events;

% Written by Cong Xu, 10/12/2013
% Steve Granick Group, MatSE, University of Illinois at Urbana-Champaign
% Last modified by Cong Xu on 05/24/2014



% ###############################################
% #                                             #
% #             START OF PROGRAM                #
% #                                             #
% ###############################################


file = '.........\*****.avi'; % filename of movie
obj = VideoReader(file);
frames = xx:xx; % usually, 1:obj.NumberOfFrames

traj = trackStephentraj_cong(obj,frames);
[traj, collisions, index] = two_particle_tracking_cong(traj, upper_threshold,'black');

index_follow = angle_filter_follow_cong(collisions,index);
[bincounts, binranges] = plot_relative_angle_1_cong(collisions(index_follow), binranges);