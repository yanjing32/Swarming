function traj=energy(traj)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% quantify energy in the system. Reference: PRL 110 228102

for n=1:size(traj,2)
    velocitymap=traj(n).velocitymap;
    energymap=((velocitymap(:,:,1).^2)+(velocitymap(:,:,2).^2))./2;
    traj(n).energy=sum(sum(energymap))./(size(energymap,1).*size(energymap,2));
end