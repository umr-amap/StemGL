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


function[]= Batch_Sim ( )

    startcputime = cputime; %cputime start

    %Generate the file with all output messages

 
    AGRO_PLANT = 0;
    PMA18 = 0;
    VIRTUAL_PLANT = 0;

    

    %get date and time
    strdate = datestr(now,'yyyy-mm-dd_HHMM');
    %Open Diary
    str = sprintf('Batch_DumpSim_%s.txt', strdate);
    diary(str);
    
    %Define Batchlist file 
    batchfiles = sprintf('Batch_Files_%s.txt', strdate);
    % Define directory entry point
    sdir = strcat('..', filesep, 'data', filesep);
    %Launch ssek for each parameter file
    IO_DirFiles(sdir, '*.par', 99, batchfiles);


    % Open batchfile and launch the run for each file 
    fbatchlist = fopen(batchfiles,'r');
    if fbatchlist
        filename = fgetl(fbatchlist);
        while ( (~feof(fbatchlist)) && (~isempty(filename)) )
            StemGL_Sim ('-i', filename);
            filename = fgetl(fbatchlist);
        end
        fclose (fbatchlist);   
    end
    
    %end of script

    fprintf (1,'\nSCRIPT TOTAL CPU TIME    %f\n', cputime-startcputime);
    
    % Close diary
    diary off
end
