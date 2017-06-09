% Function Name: find_all_pairs_cong
% This function is base on find_all_pairs.m written by Jing Yan.
% 
% This function (1) inserts missing pairs back.
%               (2) deletes the shorter trajectory
%                   e.g.    before:                     after:
%                           ooooooo--------ooo          ooooooo
%                           ooooooo--------ooo          ooooooo
%                   (if both of them are long, delete the shorter ones)
%                   (if both of them are too short, delete them all)
% 
% OUTPUT:   allpairs:     1       2       3
%                         ID1     ID2     #frame(start from 1)
% 
% Written by Cong Xu, 11/02/2013
% Steve Granick Group, MatSE, University of Illinois at Urbana-Champaign
% Last modified by Cong Xu on 11/03/2013

function allpairs=find_all_pairs_cong(traj)

% collect the information for all collision pairs for analysis.

for n=1:size(traj,2) % size(traj,2) returns the number of columns in traj
    if isempty(traj(n).pairs)==0 % means if "traj(n).pairs" is not empty
        traj(n).pairs(:,3:4)=[];
        traj(n).pairs(:,3)=n;
    end
end

allpairs=zeros(1000000,3);

count=1;

for n=1:size(traj,2)
    if isempty(traj(n).pairs)==0
        allpairs(count:count+size(traj(n).pairs)-1,:)=traj(n).pairs;
        count=count+size(traj(n).pairs);
    end
end

keep=allpairs(:,3)~=0;
allpairs=allpairs(keep,:);

for n=1:size(allpairs,1) % size(allpairs,1) returns the number of rows in allpairs
    allpairs(n,4)=traj(allpairs(n,3)).id(allpairs(n,1));
    allpairs(n,5)=traj(allpairs(n,3)).id(allpairs(n,2));
end

temp=sortrows(allpairs,[4 5 3]);
temp(:,1:2)=temp(:,4:5);
temp(:,4:5)=[];

allpairs=temp;

keep=(allpairs(:,1)>allpairs(:,2));
allpairs(keep,[1,2])=allpairs(keep,[2,1]);


% % % % ADD MISSING PAIRS BACK % % % %
% 
allpairs=sortrows(allpairs, [1 2 3]);
count=1;
index_break=zeros(3000,3);
% index_break stores the pair information of uncontinuous frames that are too far away
count_break=1;
% count_break index the row of index_break

while count<size(allpairs,1)
    if allpairs(count+1,3)-allpairs(count,3)==1 % if frames are continuous, do nothing
        count=count+1;
%         disp(count)
    elseif allpairs(count+1,1)~=allpairs(count,1) || allpairs(count+1,2)~=allpairs(count,2)
        % if frames are incontinuous, but this come from different pairs, still do nothing
        count=count+1;
%         disp(count)
    elseif allpairs(count+1,1)==allpairs(count,1) && allpairs(count+1,2)==allpairs(count,2) &&...
            allpairs(count+1,3)-allpairs(count,3)>0 && allpairs(count+1,3)-allpairs(count,3)<=5
        % if <=4 frams are lost, insert them back
        temp1=allpairs(1:count,:);
        temp3=allpairs(count+1:end,:);
        temp2=zeros(4,3);
        for t=1:allpairs(count+1,3)-allpairs(count,3)-1
            temp2(t,1:2)=allpairs(count,1:2);
            temp2(t,3)=allpairs(count,3)+t;
        end
        temp2=temp2(find(temp2(:,1)),:); % delete unused row in temp2
        allpairs=[temp1;temp2;temp3];
        count=count+allpairs(count+1,3)-allpairs(count,3);
%         disp(count)
    else
        index_break(count_break,:)=allpairs(count,:);
        count_break=count_break+1;
        count=count+1;
%         disp(count)
    end
end

index_break=index_break(find(index_break(:,1)),:); % delete unused row in index_break
clear count count_break temp1 temp2 temp3;
% 
% P.S. 
%       the conditions of the second elseif MUST be the 4 above, 
%       otherwise a endless loop may be observed
% 
%       the endless loop comes from the *sortrows.m* used above.
% 
%       e.g. allpairs could have consecutive arrays that are
%         [83,84,28;
%          83,84,29;
%          83,84,30;
%          83,84,29;
%          84,88,30;
%          84,90,34;
%          84,92,35;
%          84,92,36]
% % % % END OF THIS PART % % % %



% % % % DELETES SHORTER TRAJECTORY IN A "GAP" TRAJ % % % %
% 
[~, Ind]=ismember(index_break, allpairs, 'rows'); % find the same rows (from "index_break") in "allpairs"
%   Ind is a N*1 column that stores the starting position of the gap (>=5 frames are lost) in a trajectory

for n = 1:size(index_break,1)
    
    count_up=1;
    count_down=1;
    
    % 1st part of gap traj
    while allpairs(Ind(n)-count_up,1:2)==allpairs(Ind(n),1:2); 
                                       % allpairs(Ind(n),1:2) is [id1,id2]
       count_up=count_up+1;
%        if Ind(n)-count_up<0
%            disp('  Error: Ind < count_up, check find_all_pairs_cong.m')
%            break;
%        end
    end
    
    % 2nd part of gap traj
    while allpairs(Ind(n)+count_down,1:2)==allpairs(Ind(n),1:2); 
                                       % allpairs(Ind(n),1:2) is [id1,id2]
       count_down=count_down+1;
       if Ind(n)+count_down>size(allpairs,1)
           disp('  Error: Ind + count_down > size(allpairs,1), check find_all_pairs_cong.m')
           break;
       end
    end
    
    % delete shorter trajectory
    flg=0;
        % if flg==0, then no delete traj is executed.
        % if flg==1, then at lease one delete traj is executed.
    
    if count_up<=5
        allpairs(Ind(n)-count_up+1:Ind(n),:)=zeros(count_up,3);
        flg=1;
%         disp('delete count_up   -> OK')
    end
    
    if count_down<=5
        allpairs(Ind(n)+1:Ind(n)+count_down,:)=zeros(count_down,3);
        flg=1;
%         disp('delete count_down -> OK')
    end
    
        % when both 1st and 2nd traj are long, delete them all
    if flg==0
        allpairs(Ind(n)-count_up+1:Ind(n),:)=zeros(count_up,3);
        allpairs(Ind(n)+1:Ind(n)+count_down,:)=zeros(count_down,3);
%         disp('delete both count -> OK')
    end    
end

allpairs=allpairs(find(allpairs(:,1)),:); % delete unused row in allpairs
% 
% % % % END OF THIS PART % % % %

allpairs=sortrows(allpairs, [1 2 3]);







