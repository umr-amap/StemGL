%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% StemGL_Fit Single stem Greenlab Fitting tool and
% StemGL_Sim Single stem GreenLab Simulation tool
%
%   MatLab_Octave code. 
%
% This code is part of GREENLAB project StemGL implementation
%
% Main Author: Philippe de Reffye CIRAD-AMAP
% Secondary author: Marc JAEGER CIRAD-AMAP
%
% Created: 2018
% Version 18_10_05
%
% Copyright (C) 2018 CIRAD-AMAP 
%
% This program is free software: you can redistribute it and/or modify it
% under the terms of the Create Commons Licence  type 5, BY-NC-SA
% BY (Attribution): Licensees may copy, distribute, display and perform the work and make derivative
% works and remixes based on it only if they give the author or licensor the credits (attribution)
% in the manner specified by these.
% SA (Share-alike): Licensees may distribute derivative works only under a license identical
% ("not more restrictive") to the license that governs the original work.
% NC (Non-commercial): 	Licensees may copy, distribute, display, and perform the work and
% make derivative works and remixes based on it only for non-commercial purposes.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ret] = error_message (err_severity, err_exit_code, err_function_name, err_label)

    ret = err_exit_code;
    if (err_severity > 99)
      fprintf(1,'\nFatal Error from: %s. Severity code is : %d\n', err_function_name, err_severity);
      fprintf(1,'\nReason: %s. \n', err_label);
      fprintf(1,'\nExiting with exit_code %d\n', err_exit_code);
      error (err_label);
      return;
 
      elseif  (err_severity > 9)
        fprintf(1,'\nError from: %s. Severity code is : %d\n', err_function_name, err_severity);
        fprintf(1,'\nReason: %s. \n', err_label);
        fprintf(1,'\nReturning with exit_code %d\n', err_exit_code);
        return ;
        
        elseif  (err_severity > 0)
            fprintf(1,'\nWarning from: %s. Severity code is : %d\n', err_function_name, err_severity);
            fprintf(1,'\nReason: %s. \n', err_label);
            return ;
            
         else
            fprintf(1,'\nMessage from: %s.\n', err_function_name);
            fprintf(1,'\nReason: %s. \n', err_label);
            return ;
            
        end
end