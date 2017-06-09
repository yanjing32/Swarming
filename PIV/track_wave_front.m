function wave_front = track_wave_front(wave_form)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% This function is used to track the motion of the wave front of the
% collective particle wave. 

wave_front = zeros(size(wave_form,1),1);

threshold = 0.05;

for t = 1:size(wave_form,1)
    corr = wave_form(t,:);
    corr = corr - threshold;
    ncorr=1;
    while corr(ncorr+1)>0 && ncorr<size(corr,2)-3
    ncorr=ncorr+1;
    end

% use linear interpolation between the last positive value and first
% negative value to get correlation value. Note this value need to be
% rescaled 
    wave_front(t)=corr(ncorr)./(corr(ncorr)-corr(ncorr+1))+ncorr;
end