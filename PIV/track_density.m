function traj = track_density(obj,traj,ittsize,ovlapSize)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% this function track number of particles in each grid across the whole movie 

optional.peakmin = 0.4;
size1 = size(traj(1).velocitymap,1);
size2 = size(traj(1).velocitymap,2);

for t=1:size(traj,2)

    arr = read(obj,traj(t).frame);
    arr1=im2double(arr(1:end,1:end,1));
    
    % for the feature code, please refer to Anthony, S.M., and Granick, S. Langmuir *25*, 8152 (2009).
    ftr = features(imcomplement(arr1),1,optional);
    
    densitymap=zeros(size1,size2);
    res = traj(t).res;
    for n = 1:size(res,1)
        keep = (ftr(:,1)>= res(n,1)-ittsize/2) & ftr(:,2)>= res(n,2)-ittsize/2 & ftr(:,1)< res(n,1)+ittsize/2 & ftr(:,2)< res(n,2)+ittsize/2;
        res(n,6) = sum (keep);
        densitymap(res(n,2)./ovlapSize,res(n,1)./ovlapSize)=res(n,6); % tries to remember the mapping 
    end
    traj(t).ftr = ftr;
    traj(t).densitymap = densitymap;
    traj(t).res = res;

    disp(t)
end

% Below is an older version I use to discretely track it  
% optional.peakmin = 0.4;
% 
% for t=frames
% 
% filename = sprintf('Frame %d.mat', t);
% load(filename);
% 
% arr = read(obj,t);
% arr1=im2double(arr(1:end,1:end,1));
% 
% ftr = features(imcomplement(arr1),1,optional);
% arr = []; arr1=[];
% size1=size(velocitymap,1);size2=size(velocitymap,2);
% densitymap=zeros(size1,size2);
% for n = 1:size(res,1)
%     keep = (ftr(:,1)>= res(n,1)-ittsize/2) & ftr(:,2)>= res(n,2)-ittsize/2 & ftr(:,1)< res(n,1)+ittsize/2 & ftr(:,2)< res(n,2)+ittsize/2;
%     res(n,6) = sum (keep);
%     densitymap(res(n,2)./ovlapSize,res(n,1)./ovlapSize)=res(n,6); % tries to remember the mapping 
% end
% save(filename);
% disp(t)
% end
