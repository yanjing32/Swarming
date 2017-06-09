function [res,velocitymap]=spurious(res,threshold,ovlapSize)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% this function tries to minimize the spurious vectors based on the
% assumption that a vector should not be too different from its neighbor.
% Note this assumption might fail at the vortex or saddle point center. 


% default threshold is 300. But need fine tune for different movie 

temp=res(:,1:2)./ovlapSize;
keep=temp(:,2)==1;size2=sum(keep);
keep=temp(:,1)==1;size1=sum(keep);
velocitymap = zeros(size1,size2,4);

for t = 1:size(res,1)
    velocitymap(temp(t,2),temp(t,1),1)=res(t,3);
    velocitymap(temp(t,2),temp(t,1),2)=res(t,4);
    velocitymap(temp(t,2),temp(t,1),4)=t; % tries to remember the mapping 
end

for m = 2:size1-1
    for k = 2:size2-2
        dif=0;
        for mm=-1:1
            for kk=-1:1
                dif=dif+(velocitymap(m,k,1)-velocitymap(m+mm,k+kk,1)).^2+(velocitymap(m,k,2)-velocitymap(m+mm,k+kk,2)).^2;
            end
        end
        velocitymap(m,k,3)=dif;
        res(velocitymap(m,k,4),5)=dif;
        
        if dif>threshold % if it is spurious, replace by the average of its neighbor value
            velocitymap(m,k,1)=1/4*(velocitymap(m+1,k,1)+velocitymap(m,k+1,1)+velocitymap(m,k-1,1)+velocitymap(m-1,k,1));
            velocitymap(m,k,2)=1/4*(velocitymap(m+1,k,2)+velocitymap(m,k+1,2)+velocitymap(m,k-1,2)+velocitymap(m-1,k,2));
            res(velocitymap(m,k,4),3)=velocitymap(m,k,1);
            res(velocitymap(m,k,4),4)=velocitymap(m,k,2);
        end
        
        
    end
end

velocitymap(:,:,3:4)=[];




        