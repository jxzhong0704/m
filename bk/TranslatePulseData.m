function [dataout] = TranslatePulseData(data_raw, data_type, data_unit)
%==========================================================================
% function [dataout] = TranslatePulseData(data_raw, data_type, data_unit)
%-------------------------------------------------------------------------
% Translate data form from PULSE output 
%-------------------------------------------------------------------------
% Input data:
%	- data_raw: 	raw data from the PULSE(generate by GetPulseAsciiFile.m)
%	- data_type: 	function of the data, e.g.: Autospectrum, Frequency Response H1, and so on.
%	- data_unit:	the deired unit, e.g.: dB, linear, dBA, and so on.	
% Output data:
%	- dataout:		the data satisfied your requirement.
%--------------------------------------------------------------------------
% Author: Jiaxin Zhong
% Version control: https://github.com/jxzhong0704/m @ /bk/TranslatePulseData.m
%==========================================================================


acoustics;

dataout = data_raw;

if data_type == 'Autospectrum'
	if data_unit == 'dB'
		len_data = length(data_raw);
		for i = 1:len_data
			data_tmp = data_raw{i}(:,3);
			dataout{i}(:,3) = 20*log10(sqrt(data_tmp)/p_ref);
		end
	end
end





