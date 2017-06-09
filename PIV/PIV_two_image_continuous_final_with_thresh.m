function res=PIV_two_image_continuous_final_with_thresh(a1,b1,ittsize,ovlapSize,horSize,verSize,background) 

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% This PIV version is based on a hybrid method of FFT plus continuous shift. This avoids pixel
% locking usually seen in FFT only method.

% Interpolating the image
enlarge=10; % this sets the resolution. now resolution is 0.1 pixel 
resized_a1=imresize(a1,enlarge); % note that matlab use a bicubic interpolation. 

padsize=1000; % need to pad the periphery of the image for those at the edge to work. 
temp=zeros(size(a1,1).*enlarge+padsize*2,size(a1,2).*enlarge+padsize*2);
temp(padsize+1:padsize+size(a1,1).*enlarge,padsize+1:padsize+size(a1,2).*enlarge)=resized_a1;

% This is the main function for PIV analysis between two frames. 
% input
% a1, b1: the two images to be analyzed. Note the time difference should be
% small enough that change is not too drastic and also large enough to
% ensure high s2n ratio.
% ittsize: subwindow size. default is 32-64. this is the size of the
% subwindows. Note this is different from ovlapSize!!!
% ovlapSize: the amount of shift when slicing across the image. normally
% half of ittsize.

% default setting: ittsize=32;ovlapSize=16;
origin=[0 0];
% Prepare the results storage;
% structure of result is (x y xvelocity y velocity)
            numcols = floor((horSize-ittsize)/ovlapSize+1);
            numrows = floor((verSize-ittsize)/ovlapSize+1);
            res = zeros(numcols*numrows,4);
            resind = 0;
            
            a2 = zeros(ittsize,ittsize);
            b2 = zeros(ittsize,ittsize);
            Nfftsize = 2*ittsize; % this makes fft results in a image 4 times the size 
            
% Start the loop for each interrogation block    
         
            for m = 1:ovlapSize:verSize - ittsize + 1 % vertically correct
                for k = 1:ovlapSize:horSize-ittsize + 1 % horizontally correct
                   
                        
                    % first, need to get the integral of the displacement.
                    % otherwise it will be too slow to obtain 
                        a2 = double(a1(m:m+ittsize-1,k:k+ittsize-1));
                        b2 = double(b1(m:m+ittsize-1,k:k+ittsize-1));
                        c = 0;
                        
                        % try to remove regions without any particles. 
                        if sum(sum(a2))>background*ittsize*ittsize && sum(sum(b2))>background*ittsize*ittsize
                            c = cross_correlate(a2,b2,Nfftsize,Nfftsize); 
                        end
                     
                     if sum(sum(c))~=0  % avoid blank image
                 
                            [peakx,peaky]=find(c==max(max(c))); % get the integral part
                            u_int = ittsize-peaky(1); % the displacemnt vector's projection in x but the ----- direction
                            v_int = ittsize-peakx(1); % the displacemnt vector's projection in y but the ||||| direction
                            
                            % now based on the integral, first shift the
                            % first frame to the rough position
                            ds_temp=inf;
                            mm_temp=-5;
                            kk_temp=-5;
% %                             
                            for mm = -5:5
                                for kk = -5:5
%                                     
                                    % Now shift the the image close to the
                                    % actual displacement and locally
                                    % carefully search 
                                   
                                    temp_m = (m-1)./ovlapSize;
                                    temp_k = (k-1)./ovlapSize;
                                    
  % if do calculation between two 10X images will be very slow, compare the shrinked one.  
                                    a2_virtual = temp(padsize+1+temp_m*ovlapSize*enlarge-mm-v_int*enlarge:padsize+ittsize*enlarge+temp_m*ovlapSize*enlarge-mm-v_int*enlarge,padsize+1+temp_k*ovlapSize*enlarge-kk-u_int*enlarge:padsize+ittsize*enlarge+temp_k*ovlapSize*enlarge-kk-u_int*enlarge);
                                    a2_virtual = imresize(a2_virtual,1/enlarge);
                                                                                                         
                                    ds = sum(sum((a2_virtual-b2).^2)); % use the simplest assumption of difference squared. 
                                    
                                    % find the mm and kk where difference
                                    % is smallest
                                    if ds < ds_temp
                                        ds_temp=ds;
                                        mm_temp=mm;
                                        kk_temp=kk;
                                    end
%                                     disp([mm nn]);
                                end
                                
                            end
                        % add the integral part and non integral part
                        % together
                          u = u_int+kk_temp/enlarge;
                          v = v_int+mm_temp/enlarge;
                     else
                            u=0; v=0;
                     end
                        y = origin(2) + m + ittsize/2-1;
                        x = origin(1) + k + ittsize/2-1;
                                  
                                       
                        resind = resind + 1;
                        res(resind,:) = [x y u v]; 
%                     
                        
                end
              disp([m]);

            end