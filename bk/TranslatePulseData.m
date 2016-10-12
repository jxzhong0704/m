function [dataout] = TranslatePulseData(datain)



acoustics;

data_raw = datain{1};
data_type = datain{2};
data_spec = datain{3};

dataout = data_raw;

if data_type == 'Autospectrum'
	if data_spec == 'dB'
		len_data = length(data_raw);
		for i = 1:len_data
			data_tmp = data_raw{i}(:,3);
			dataout{i}(:,3) = 20*log10(sqrt(data_tmp)/p_ref);
		end
	end
end





