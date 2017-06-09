% Function Name: plot_relative_angle_1_cong
% 
% This function plots <probability density> vs <abs('theta_1'-'theta_2')>
% for follow events.
% 
% INPUT:  (1) "collisions_follow_all": the combined "collisions_follow"
%         (2) "binranges" : usually '0:pi/20:pi'
% 
% OUTPUT:   plot <probability density> vs <abs('angle_1'-'angle_2')> for
%           follow events
%           ('angle_1' or 'angle_2' are the absolute velocity direction of
%           a particle. Check *collision_property_cong.m* for details.)
%
% Written by Cong Xu, 05/28/2014
% Steve Granick Group, MatSE, University of Illinois at Urbana-Champaign
% Last modified by Cong Xu on 05/28/2014

function [bincounts, binranges] = plot_relative_angle_1_cong(collisions_follow_all, binranges)

data = zeros(size(collisions_follow_all,2),5);

for m = 1 : size(collisions_follow_all,2)
    ftr = collisions_follow_all(m).ftr;
    
    data(m,1) = abs( mod(ftr(1,3)-ftr(1,6)+pi,2*pi)-pi );
    % abs('angle_1'-'angle_2') for the 1st frame
    
    for n = 1 : 3
        if n == 1
            temp = ceil(size(ftr,1)*n/4);
        else
            temp = floor(size(ftr,1)*n/4);
        end
        data(m,n+1) = abs( mod(ftr(temp,3)-ftr(temp,6)+pi,2*pi)-pi );
    end
    
    data(m,5) = abs( mod(ftr(end,3)-ftr(end,6)+pi,2*pi)-pi );
end

bincounts = histc(data, binranges);
bin_prob = bincounts/size(collisions_follow_all,2);

% Below is what *plot_relative_angle_2_cong.m* does.

figure;
rainbow_cong([binranges', bin_prob])

set(gca, 'XLim', [0 pi])
set(gca, 'XTick',[0,pi/4,pi/2,3*pi/4,pi])
set(gca, 'XTickLabel', {'0';'pi/4';'pi/2';'3pi/4';'pi'})
ylabel('P(|\phi_1-\phi_2|)')
xlabel('|\phi_1-\phi_2|')

h = colorbar;
get(h,'YTickLabel');
set(h,'YTick',[7:13:65]);
set(h,'YTickLabel',{'First Frame';'1/4 Traj';'1/2 Traj';'3/4 Traj';'Last Frame'});


%%% COMBINE ALL COLLISIONS_FOLLOW TOGETHER

% filename = sprintf('FollowEvent 91 (%d).mat', 1);
% load(filename);
% collisions_follow_all = struct;
% collisions_follow_all = collisions_follow;
% 
% for m = 2:12
%     filename = sprintf('FollowEvent 91 (%d).mat', m);
%     load(filename);
%     collisions_follow_all = [collisions_follow_all, collisions_follow];
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%