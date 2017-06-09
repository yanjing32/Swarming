   
function track_pattern_discretesave_with_thresh(obj,frames,ittsize,ovlapSize,range1,range2,time_diff,background)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% this function track the PIV and save them as discrete files, using the
% hybrid PIV continuous shift method. 

for t = 1:size(frames,2)
    [a1,b1,verSize,horSize]=Image_for_PIV(obj,frames(t),frames(t)+time_diff,ittsize,range1,range2);
    
    % Please refere to the main tracking code. 
    res=PIV_two_image_continuous_final_with_thresh(a1,b1,ittsize,ovlapSize,horSize,verSize,background) ;

    filename = sprintf('Frame %d.mat', frames(t));
    save(filename);
    disp(t)
end


    
