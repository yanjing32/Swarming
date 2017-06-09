function traj = stiching(frames_t)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% this function stiches together the tracked result by
% track_patter_discretesave_with_thresh
% much easier to handle later

% traj=struct(size(frames,2),1);
traj=struct;

ttttt=1;

for fff=frames_t
    filename = sprintf('Frame %d.mat',fff);
    load(filename);
    traj(ttttt).frame = fff;
    traj(ttttt).res = res;
    ttttt=ttttt+1;
    disp(fff)
end
