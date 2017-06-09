function traj=entrophy(traj)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% quantify entrophy in the system. Reference: PRL 110 228102

for n=1:size(traj,2)
    vorticity=traj(n).vorticitymap;
    vorticity=(vorticity.^2)/2;
    traj(n).omega=sum(sum(vorticity))./(size(vorticity,1).*size(vorticity,2));
end