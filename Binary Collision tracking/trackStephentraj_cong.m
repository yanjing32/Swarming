% Function Name: trackStephentraj_cong
% This function is base on *trackStephentraj.m* written by Jing Yan.
% 
% This function use VideoReader.m instead of mmreader.m, because the latter
% is about to be discarded by MATLAB.
% trackStephentraj_cong.m also exhibits an improved efficiency.
% 
% Written by Cong Xu, 11/02/2013
% Steve Granick Group, MatSE, University of Illinois at Urbana-Champaign
% Last modified by Cong Xu on 04/23/2014

function traj = trackStephentraj_cong(obj,frames)
% frames should be xx:xx

count = 1;

for t = frames
   
    arr = read(obj,t);
    arr1 = arr(:,:,1);

    [ftr, radii] = imfindcircles(arr1,[12 17],'ObjectPolarity','dark','Method','Twostage','Sensitivity',0.87);
%   [12 17] is the probable radius range.

    if isempty(ftr)
        disp(['Frame #' num2str(t) ' has no particle in it.'])
        continue;
    else
        [ftr, radii] = CrystalTrackMethod(ftr,arr1,14,radii); % 14 is the average radii
        if isempty(radii)
            disp(['Frame #' num2str(t) ' has no particle in it.'])
            continue;
        else
            ftr(:,5) = radii;
            traj(count).ftr = ftr;
            traj(count).frame = t; % traj.frame is the frame number
            count = count+1;
        end
    end
    disp(t)
    
end


% Output result:
% 1             2               3           4           5
% x (center)    y (center)      theta       rho         radius

% [theta,rho]=cart2pol(dx,dy); --> indicating the displacement