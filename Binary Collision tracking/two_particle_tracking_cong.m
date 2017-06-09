% Function Name: two_particle_tracking_cong
% 
% This function tracks the two particle collision movies.
% 
% INPUT:  (1) "traj": output of *linktraj_simple.m*
%         (2) Type: should be STRING format
%                   'black' --> METAL  side forward
%                   'white' --> SILICA side forward
%         (3) "upper_threshold" = 91 or 75 (3 or 2.5 particle diameter)
% 
% OUTPUT: (1) "traj" 
%         (2) "collisions"
%         (3) "index":      index of good events in variable "collisions"
%
% Written by Cong Xu, 10/22/2013
% Steve Granick Group, MatSE, University of Illinois at Urbana-Champaign
% Last modified by Cong Xu on 11/03/2013

function [traj, collisions, index] = two_particle_tracking_cong(traj, upper_threshold, Type)

traj = linktraj_simple(traj,20,0);

lower_threshold = 30;

traj = find_pairs_cong(traj,lower_threshold,upper_threshold);

allpairs = find_all_pairs_cong(traj);

collisions = collision_structure(traj,allpairs);

collisions = collision_property_cong(collisions, Type);

index = collision_best_cong(collisions);

disp('Done!')