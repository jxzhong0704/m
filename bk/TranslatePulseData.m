function [dataout] = TranslatePulseData(data_raw, data_type, data_unit)
%==========================================================================
% function [dataout] = TranslatePulseData(data_raw, data_type, data_unit)
%-------------------------------------------------------------------------
% Translate data form from PULSE output 
%-------------------------------------------------------------------------
% Input data:
%	- data_raw: 	raw data from the PULSE(generate by GetPulseAsciiFile.m).
%                       Attention: this is in CELL type.
%	- data_type: 	function of the data, e.g.(which correspond the name in PULSE): 
%                       Autospectrum, Frequency Response H1, and so on.
%	- data_unit:	the deired unit, e.g.: dB, linear, dBA, dBB, dBC, dBD and so on.
%                       mag: magnitude
% Output data:
%	- dataout:		the data satisfied your requirement.
%--------------------------------------------------------------------------
% Author: Jiaxin Zhong
% Version control: https://github.com/jxzhong0704/m @ /bk/TranslatePulseData.m
%==========================================================================


acoustics_constants; % https://github.com/jxzhong0704/m @ acoustics_constants.m

dataout = data_raw;

switch data_type
    case 'Autospectrum'
        if strcmp(data_unit,'linear')
            len_data = length(data_raw);
            for i = 1:len_data
                data_tmp = data_raw{i}(:,3);
                dataout{i}(:,3) = sqrt(data_tmp);
            end
        end
        data_unit_trunc = data_unit(1:2);
        if strcmp(data_unit_trunc,'dB')
            len_data = length(data_raw);
            for i = 1:len_data
                data_tmp = data_raw{i}(:,3);
                dataout{i}(:,3) = 20*log10(sqrt(data_tmp)/p_ref);
            end

            if length(data_unit)>2
                data_unit_tail = data_unit(3:end);
                len_data = length(data_raw);
                for i = 1:len_data
                    data_tmp = dataout{i}(:,3);
                    f_tmp = dataout{i}(:,2);
                    dataout{i}(:,3) = weighting(f_tmp,data_tmp,data_unit_tail);
                end
            end
        end
        
    case 'Frequency Response H1'
        if strcmp(data_unit,'mag')
            for i = 1:length(data_raw)
                data_tmp = data_raw{i};
                data_mag = sqrt(data_tmp(:,3).^2+data_tmp(:,4).^2);
                dataout{i} = [data_tmp(:,1),data_tmp(:,2),data_mag];
            end
        end
end





