function arrow_plot2_dilute(res,scale,arrowscale,arrowangle,color,linewidth,ovlapSize,dilute_scale)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% this function plot the arrow. on vorticitympa etc
% only part of arrow is plotted, set by dilute_scale

% res(:,1:2) is the position of the starting point
% scale the velocity field
% arrowscale relative to the vector scale

% to make movie, need clf to close each frame


keep = mod(res(:,1),dilute_scale.*ovlapSize)==0;
res = res(keep,:);
keep = mod(res(:,2),dilute_scale.*ovlapSize)==0;
res = res(keep,:);

res(:,1)=res(:,1)./ovlapSize;
res(:,2)=res(:,2)./ovlapSize;
line([res(:,1)-scale*res(:,3) res(:,1)+scale*res(:,3)]',[res(:,2)-scale*res(:,4) res(:,2)+scale*res(:,4)]','Color',color,'LineWidth',linewidth);


res(:,5)=res(:,1)+scale*res(:,3);
res(:,6)=res(:,2)+scale*res(:,4);
[res(:,7),res(:,8)]=cart2pol(res(:,3),res(:,4));
res(:,9)=res(:,7)+arrowangle;
res(:,10)=res(:,7)-arrowangle;

line([res(:,5) res(:,5)-arrowscale*scale*res(:,8).*cos(res(:,9))]',[res(:,6) res(:,6)-arrowscale*scale*res(:,8).*sin(res(:,9))]','Color',color,'LineWidth',linewidth);
line([res(:,5) res(:,5)-arrowscale*scale*res(:,8).*cos(res(:,10))]',[res(:,6) res(:,6)-arrowscale*scale*res(:,8).*sin(res(:,10))]','Color',color,'LineWidth',linewidth);

 set(gca,'YDir','reverse')
daspect([1 1 1]);

