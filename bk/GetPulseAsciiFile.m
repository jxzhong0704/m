function [dataout]=GetPulseAsciiFile(BKFilename)  
% =========================================================================
%   - This function read the output ascii file of PULSE Labshop.
%   - This function can also be used to read the output ascii file
%   from "Bridge to Matlab" application of PULSE LabShop. If this is the
%   case, you have to run the code called 'BKFiles.m' created by Pulse LabShop.
%   - The output data is given in a cell array.
%
% -------------------------------------------------------------------------
% Author: Jiaxin Zhong
% Version control: https://github.com/jxzhong0704/bk/
% =========================================================================

warning('off','MATLAB:dispatcher:InexactMatch');

% preallocating memory
dataout = [];
stop = [];
cnt = 0;

% Read the file
fid = fopen(BKFilename);
while isempty(stop) % repeat the read header
    tline = fgetl(fid);
    if tline == -feof(fid) %eof
        break
    end
    % Read header
    while isempty(stop)
        tline = fgetl(fid);
        if tline == -feof(fid) %eof
            break
        end
        stop = str2num(tline); %stops when it finds a number
    end        
    % Read data
    data = [];
    cnt = cnt + 1;
    while ~isempty(stop)
        linedata = sscanf(tline,'%f')'; %read row of data
        data = [data; linedata]; %collect data
        dataout{cnt} = data;  %assign data to cell
        tline = fgetl(fid);
        stop = str2num(tline); %stops when it finds a char
    end
end
fclose(fid);
