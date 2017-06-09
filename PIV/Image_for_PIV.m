function [a1,b1,verSize,horSize]=Image_for_PIV(obj,framenumber1,framenumber2,ittsize,range1,range2)

% Written By Jing Yan, University of Illinois at Urbana-Champaign. 
% Last modified by Jing Yan on 06/8/2016

% this function reads the two images for PIV analysis
% ittsize is the subwindow size. images are trancated to integral number of
% subwindows.

arr = read(obj,framenumber1);
arr1=arr(1:end,1:end,1);
arr1=arr1(range1,range2);
verSize=size(arr1,1);
horSize=size(arr1,2);
a1=arr1(1:floor(verSize/ittsize)*ittsize,1:floor(horSize/ittsize)*ittsize);


arr = read(obj,framenumber2);
arr2=arr(1:end,1:end,1);
arr2=arr2(range1,range2);
b1=arr2(1:floor(verSize/ittsize)*ittsize,1:floor(horSize/ittsize)*ittsize);
verSize=size(a1,1);
horSize=size(a1,2);