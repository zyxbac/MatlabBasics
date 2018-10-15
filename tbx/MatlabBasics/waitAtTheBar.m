classdef waitAtTheBar
%waitAtTheBar A tiny wrapper around waitbar in class form.
%
% MIT License
%
% Copyright (c) 2018 Michael Breuer
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
    
    properties (Access = private)
        theWaitbar;
    end
    
    methods
        function obj = waitAtTheBar(title, show_progress)
            if nargin == 0
                obj.theWaitbar = waitbar(0, '', 'name', 'wait at the bar');
            else
                if ~show_progress
                    return
                else
                    obj.theWaitbar = waitbar(0, '', 'name', title);
                end
            end
        end
        
        function showWaitProgress(self, progress, message)
            waitbar(progress, self.theWaitbar, message);
        end
        
        function closeWaitBar(self)
            close(ancestor(self.theWaitbar, 'figure'));
        end

        function delete(self)
            closeWaitBar(self);
        end

    end %public
    
end %waitAtTheBar

% EOF
