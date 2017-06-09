% Function Name: collision_property_cong
% This function is base on collision_property.m written by Jing Yan.
% 
%
% type_name == 'black' --> METAL  side forward
% type_name == 'white' --> SILICA side forward
% 
% Written by Cong Xu, 10/12/2013
% Steve Granick Group, MatSE, University of Illinois at Urbana-Champaign
% Last modified by Cong Xu on 11/03/2013

function collisions=collision_property_cong(collisions,type_name)

if strcmp(type_name,'black')
    disp('  You are in Metal side forward situation.')
elseif strcmp(type_name,'white')
    disp('  You are in Silica side forward situation.')
else
    disp('  Wrong "type_name" input! Check *collision_property_cong.m* for details.')
    return
end

for n=1:size(collisions,2)
    ftr=collisions(n).ftr;
    ftr(:,7:8)=ftr(:,4:5)-ftr(:,1:2); % the vector from particle 1 to particle 2
    
    [ftr(:,9),ftr(:,10)]=cart2pol(ftr(:,7),ftr(:,8)); % orientation and length of the vector;
    
%       e.g. cart2pol(1,1)  =>  [pi/4,  1.4142]
%       e.g. cart2pol(1,-1) =>  [-pi/4, 1.4142]
%       e.g. cart2pol(-1,1) =>  [3*pi/4,  1.4142]
%       e.g. cart2pol(-1,-1)=>  [-3*pi/4, 1.4142]
%       e.g. cart2pol(1,0)  =>  [0,1]
%       e.g. cart2pol(-1,0) =>  [pi,1]

    if type_name == 'black'
        ftr(:,3)=mod((ftr(:,3)+pi)+pi,2*pi)-pi;
        ftr(:,6)=mod((ftr(:,6)+pi)+pi,2*pi)-pi;
        % rotate the particle velocity and let it points to BLACK head's direction
    end
    
    ftr(:,11)=mod((ftr(:,3)-ftr(:,9))+pi,2*pi)-pi; % theta_1 -> [-pi:pi] 
    ftr(:,12)=mod((ftr(:,6)-ftr(:,9))+pi,2*pi)-pi; % theta_2 -> [-pi:pi]
    
%       y=mod(x+pi,2*pi)-pi
%       whatever x is, this algorithm can let y lies in [-pi,pi]
   
    collisions(n).ftr=ftr;
end


%   1   2   3        4   5     6        7       8       9           10      11        12
%   x1  y1  angle_1  x2  y2    angle_2  R(x)    R(y)    angle(R)    |R|     theta_1   theta_2
