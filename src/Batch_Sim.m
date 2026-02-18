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
% Version 26_02_18
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


function[]= Batch_Sim ( )

    startcputime = cputime; %cputime start

    %get date and time and put it in string
    strdate = datestr(now,'yyyy-mm-dd_HHMM');
    
    %Generate the dump from all console output messages
    str = sprintf('BatchSim_Dump_%s.txt', strdate);
    diary(str);
    
    %Define Batchlist file to process  
    batchfiles = sprintf('BatchSim_Files_%s.txt', strdate);
    % Define directory entry point
    sdir = strcat('..', filesep, 'data', filesep);
    %Launch ssek for each parameter file recursively
    nbf = IO_DirFiles(sdir, '*.par', 99, batchfiles);


    % If files to process (nbf > 0) Open batchfile and launch the run for each file 
    fbatchlist = fopen(batchfiles,'r');
    if nbf > 0 && fbatchlist
        % loop on reading files to process until end of file
        filename = fgetl(fbatchlist);
        while ( (~feof(fbatchlist)) && (~isempty(filename)) )
            % lauch StemGL_Sim with input file as option
            StemGL_Sim ('-i', filename);
            % load next filename
            filename = fgetl(fbatchlist);
        end
        fclose (fbatchlist);   
    end
    
    %end of scrip
    fprintf (1,'\nSCRIPT TOTAL CPU TIME    %f\n', cputime-startcputime);
    
    % Close diary (dumpfile)
    diary off
end
