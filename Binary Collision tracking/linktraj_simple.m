function a=linktraj_simple(a,distance,boundary_cutoff)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% This function link the tracked trajectory
% each particle is given an ID

lost=size(a(1).ftr,1)+1; % If a particle does not find its counterpart in the previous frame, it is given a new ID, staring a new traj.  

% extra step: particles at the boundary give many artificial results, such
% as number of neighbors. So remove first. Default boundary_cutoff = 50
for frame=1:size(a,2)
    keep=(a(frame).ftr(:,1)>boundary_cutoff & a(frame).ftr(:,2)>boundary_cutoff & a(frame).ftr(:,1)<1280-boundary_cutoff & a(frame).ftr(:,2)<959-boundary_cutoff);
    a(frame).ftr=a(frame).ftr(keep,:);
end

for n=1:size(a(1).ftr,1)
    a(1).id(n)=n; % for the frist frame, sequeantially give ID
end
a(1).id=a(1).id';

for frame=1:size(a,2)-1;
% for frame=1:2
    length=size(a(frame).ftr,1);
    length2=size(a(frame+1).ftr,1);
    a(frame+1).id=zeros(length2,1);
    % For each particle in current frame, try to find its counter part in
    % the next frame (within a radius<distant)
  
    for n=1:length
        h=ones(length2,1);
        [X,~]=meshgrid(a(frame).ftr(n,1:2),h);
        check=a(frame+1).ftr(:,1:2)-X;
        check(:,3)=sqrt(check(:,1).^2+check(:,2).^2);
        ind=find(check(:,3)==min(check(:,3)));
        if min(check(:,3))<distance
            
                a(frame+1).id(ind)=a(frame).id(n);
                a(frame).vel(n,:)=a(frame+1).ftr(ind,1:2)-a(frame).ftr(n,1:2);
            
        end
    end
    % Taking care of the missing particles. 
    for n=1:size(a(frame+1).ftr)
        if a(frame+1).id(n)==0
            a(frame+1).id(n)=lost;
            lost=lost+1;
        end
    end
%     disp(frame)
end
