function [c] = cross_correlate(a2,b2,NfftHeight,NfftWidth)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% this function uses fast fft to calculate the cross correlation between
% two images. 
% from online source openPIV. need citation. 
a2 = a2 - mean2(a2);
b2 = b2 - mean2(b2);

b2 = b2(end:-1:1,end:-1:1);

ffta=fft2(single(a2),NfftHeight,NfftWidth);
fftb=fft2(single(b2),NfftHeight,NfftWidth);

c = real(ifft2(ffta.*fftb));
c(c<0) = 0;
