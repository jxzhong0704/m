function [dataout] = GetSysnoiseFile(SysFilename)  
%==========================================================================
%   - This function read the output ascii file of SYSNOISE Rev. 5.6
%	- By input the following code stream in SYSNOISE, you get the result.txt
%		which contains all the data you need including sound pressure, 
%		velocity, and so on(frequency at 31.5, 40, and 50 Hz for example):
%			Export Results Format Free
%			Frequency 31.5 40 50
%			File result.txt Return
%	- You may see more about SYSNOISE code stream at my blog:
%		http://jxzhong.top/247.html
%   - The output data is given in a cell array.
%--------------------------------------------------------------------------
% Input data:
%	- SysFilename: 	Filename of sysnoise file(direcotrial style)	
% Output data:
%	- dataout:		A [cnt_p x 1] cell, where cnt_p is the total number of 
%						field points. dataout{cnt_p} is [cnt_f x 4] matrix
%						whose first column corresponding frequencies, and 2nd,
%						3rd and 4th column represent pressure(real), pressure(imaginary),
%						and SPL respectively.
%
%--------------------------------------------------------------------------
% Author: Jiaxin Zhong
% Version control: https://github.com/jxzhong0704/m @ /sysnoise/GetSysnoiseFile.m
%==========================================================================

warning('off','MATLAB:dispatcher:InexactMatch');

% preallocating memory
dataout = [];
cnt_f = 0; % count for frequency

% read the file
fid = fopen(SysFilename);
while 1
	tline = fgetl(fid);
	if tline == -feof(fid)
		break
	end

	while strcmp(tline,'FREQUENCY')
		tline = fgetl(fid);
		if tline == -feof(fid)
			break
		end
		f_tmp = str2num(tline);
		cnt_f = cnt_f+1;
		dataout{cnt_f,1} = f_tmp;

		data = [];
		while isempty(data)
			tline = fgetl(fid);
			if tline == -feof(fid)
				break
			end
			if strcmp(tline,'FREQUENCY')
				break
			end
			if strcmp(tline,'PRESSURE VALUES')
				tline1 = fgetl(fid);
				tline2 = fgetl(fid);
				if tline2 == -feof(fid)
					break
				end
				data = str2num(tline2);
				data_p = [];
				cnt_p = 0;
				while ~isempty(data)
					linedata1 = sscanf(tline1,'%f');
					linedata2 = sscanf(tline2,'%f');
					cnt_p = cnt_p+1;
					data_p = [data_p,[linedata1(3);linedata1(4);linedata2(2)]];
					tline1 = fgetl(fid);
					tline2 = fgetl(fid);
					data = str2num(tline1);
				end
				dataout{cnt_f,2} = data_p;
			end
		end
	end
end

% rearrange dataout
data = dataout;
dataout = [];
for p = 1:cnt_p
	buf = [];
	for f = 1:cnt_f
		buf = [buf;[data{f,1},data{f,2}(:,p).']];
	end
	dataout{p,1} = buf;
end
		

