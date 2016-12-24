function [data_w] = weighting(f, spec, w_type)
%=========================================================================
% function [data_w] = weighting(f, spec, w_type)
%-------------------------------------------------------------------------
% apply A-, B-, C-, and D-weighting of given spectrum
%-------------------------------------------------------------------------
% Input data:
%	- f:		frequency
%	- spec:		spectrum (like SPL, SWL and etc.)
%	- w_type:	type of weighting (A, B, C, or D in char)
%					while: -A, -B, -C, -D:	A/B/C/D weighing to linear
% Output data:
%	- data_w:	spectrum which is A(or B, C, D)-weighted
%-------------------------------------------------------------------------
% Example:
%	[data_w] = weighting([100,200],[1,2],'-B');
%	[data_w] = weighting(1000,5,'A');
%-------------------------------------------------------------------------
% Author: Jiaxin Zhong
% Version control: https://github.com/jxzhong0704/m @ acoustics/weighting.m
%=========================================================================

w_sign = 1;
if strcmp(w_type(1),'-')
	w_sign = -1;
	w_type = w_type(2);
end

switch w_type
	case 'A'
		R = 12200^2*f.^4./((f.^2+20.6^2).*sqrt((f.^2+107.7^2).*(f.^2+737.9^2)).*(f.^2+12200^2));
		W = 2+20*log10(R);
	case 'B' 
		R = 12200^2*f.^3./((f.^2+20.6^2).*sqrt((f.^2+158.5^2)).*(f.^2+12200^2));
		W = 0.17+20*log10(R);
	case 'C'
		R = 12200^2*f.^2./((f.^2+20.6^2).*(f.^2+12200.^2));
		W = 0.06+20*log10(R);
	case 'D'
		h = ((1037918.48-f.^2).^2+1080768.16*f.^2)./((9837328-f.^2).^2+11723776*f.^2);
		R = f/6.8966888e-5.*sqrt(h./((f.^2+79919.29).*(f.^2+1345600)));
		W = 20*log10(R);
end

data_w = spec+w_sign*W;
