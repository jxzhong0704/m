function [dataout] = iso3744_field_point(r,num)
%==========================================================================
% function [dataout] = iso3744_field_point([r,[num]])
%-------------------------------------------------------------------------
% Generate coordinates of key microphone positions(1-10) and additional
%	microphone postions(11-20) according to ISO 3744-1994 Acoustics - 
%	Determination of sound power levels of noise sources using sound
%	pressure - Engineering method in an essentially free field over a 
%	reflecting plane.
%-------------------------------------------------------------------------
% Input data:
%	- r: 			radius of the hemisphere
%	- num: 			number of microphones
% Output data:
%	- dataout:		the data satisfied your requirement with size 3xnum
%						whose rows corresponding x, y, and z, respectively.
%--------------------------------------------------------------------------
% Author: Jiaxin Zhong
% Version control: https://github.com/jxzhong0704/m @ /acoustics/iso3744_field_point.m
%==========================================================================

dataout = ...
	[-0.99 0.5 0.5 -0.45 -0.45 0.89 0.33 -0.66 0.33 0 0.99 -0.50 -0.50 0.45 0.45 -0.89 -0.33 0.66 -0.33 0;
	0 -0.86 .86 .77 -.77 0 .57 0 -.57 0 0 .86 -.86 -.77 .77 0 -.57 0 .57 0;
	.15 .15 .15 .45 .45 .45 .75 .75 .75 1 .15 .15 .15 .45 .45 .45 .75 .75 .75 1];

r_default = 1;
num_default = 10;

switch nargin
	case 0
		r = r_default;
	case 1
		num = num_default;
	case 2
		;
end

dataout = dataout*r;
dataout = dataout(:,1:num);

