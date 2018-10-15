function convert_rgb_to_cmyk(filename)
% convert_rgb_to_cmyk convert RGB => CMYK within an EPS file
%
% Converts a eps file from RGB to CMYK as post-processing function.
%  Overwrites the existing file!

%%
% Copyright (c) 2014, Oliver J. Woodford, Yair M. Altman
% Copyright (c) 2018 Michael Breuer
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution.
% 
% * Neither the name of the {organization} nor the names of its
%   contributors may be used to endorse or promote products derived from
%   this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

%%

try
    % Read the EPS file into memory
    file_content = read_full_textfile(filename);
    
    % Replace all gray-scale colors
    file_content = regexprep(file_content, '\n([\d.]+) +GC\n', '\n0 0 0 ${num2str(1-str2num($1))} CC\n');
    
    % Replace all RGB colors
    file_content = regexprep(file_content, '\n[0.]+ +[0.]+ +[0.]+ +RC\n', '\n0 0 0 1 CC\n');  % pure black
    file_content = regexprep(file_content, '\n([\d.]+) +([\d.]+) +([\d.]+) +RC\n', '\n${sprintf(''%.4g '',[1-[str2num($1),str2num($2),str2num($3)]/max([str2num($1),str2num($2),str2num($3)]),1-max([str2num($1),str2num($2),str2num($3)])])} CC\n');
    
    % Overwrite the file with the modified contents
    write_full_textfile(filename, file_content);
catch
    % never mind - leave as is...
end
end

% EOF
