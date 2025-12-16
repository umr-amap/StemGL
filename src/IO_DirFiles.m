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
% Created: 2025
% Version 25_12_15
%
% Copyright (C) 2025 CIRAD-AMAP
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


function [nbfiles] = IO_DirFiles(directory, pattern, max_depth, outfilename)
%
% function [filelist] = IO_DirFiles(directory, pattern, max_depth, outfilename)
%
%   Retrieves files from directory maching the pattern lookin in
%   subdirectories until reaching depth of max_depth
%
%   I   directory:   directory entry point
%   I   pattern:     pattern filter. Examples: full*.txt, empty means no filter (*.*)  
%   I   max_depth:   1 : in current directory, -1 recursively with no depth limit 
%   I   outfilename: output file name
%
%   O   nbfiles:     the number of selected filenames stored in outfilename
%
%   Last version 2025/12/15. Main author MJ
%   Copyright Cirad-AMAP
%

    nbfiles = 0;

    % open file to dump selected files to be processed
    fbatchlist = fopen(outfilename,'w');
    if fbatchlist
        % Check if pattern is not empty else change to all (*)
        npat = size(pattern);
        if npat(1) > 0
            patfilter = pattern;
        else
            patfilter = '*';
        end
        % explore the top directory (recursively until max_depth level)
        % max_depth level)
        nbfiles = IO_DirGetFiles(directory, patfilter, max_depth, fbatchlist, nbfiles);
        fclose (fbatchlist);
        fprintf (1,'File list %s   with %d selected files\n', outfilename, nbfiles);
    end

end


function [nbfiles] = IO_DirGetFiles(directory, pattern, max_depth, fileId, nbfiles)
%
% function [nbfiles] = IO_DirGetFiles(directory, pattern, max_depth, fileId, nbfiles)
%
%   Retrieves files from directory maching the pattern lookin in
%   subdirectories until reaching depth of max_depth (is recursive)
%
%   I   directory:  directory entry point
%   I   pattern:    pattern filter. Examples: full*.txt, empty means no filter (*.*)  
%   I   max_depth:  1 : in current directory, -1 recursively with no depth limit 
%   I   fileId:     fileId to dump the fillname in
%
%   I-O nbfiles:    the number of selected filenames
%
%   Last version 2025/12/15. Main author MJ
%   Copyright Cirad-AMAP
%

    %fprintf (1,'\n Dir:%s   Filter:%s   Depth:%d\n', directory, pattern, max_depth);
    
    newnbfiles = 0;
    
    % Check first single files with the pattern filter
    sdir = strcat(directory, filesep, pattern);
    %get the corresponding table of filenames (strings)
    bfiles = dir(sdir);
    
    %get number of single files 
    number = size(bfiles);
    nb = number(1);
    %fprintf (1,'Number of filtered files: %d\n', nb); 
    
    % loop on the filename table
    nf = 0;
    while (nf < nb)
        nf = nf+1;
        %retieve file fulname 
        selectedfile = strcat(directory, bfiles(nf).name);
        % write the file fullname in the batchfile if succeffully opened
        % and increment number of files
        if (fileId)
           newnbfiles = newnbfiles + 1; 
           fprintf (fileId, '%s\n', selectedfile);
        end
        fprintf (1,'Storing %d (%d)  %s from %s\n', nf, nbfiles+newnbfiles, selectedfile, directory);   
    end
    
    % update the number of files allready written in the batch file
    nbfiles = nbfiles + newnbfiles;
    
    % check now directory files
    % Process if maximal level of recursion not reached
    max_depth = max_depth - 1;
    if max_depth > 0
       % get the full directory content and the number of items
       dfiles = dir(directory);
       numberf = size(dfiles);
       nbf = numberf(1);
       %fprintf (1,'Number of files: %d in %s\n', nbf, directory);
       
       %loop in the directory list 
       n = 0;
       while (n < nbf)
           n = n+1;
           % Check the name size
           ns = size(dfiles(n).name);
           nd = ns(2);
           %consider only directories, and avoid '.' (starting directories, ie hidden, father, current )) 
           if (dfiles(n).isdir && dfiles(n).name(1) ~= '.')
              % get directory full path
              dirfile = strcat(directory, filesep, dfiles(n).name, filesep);
              %fprintf (1,'IO_DirFiles(%s, %s, %d, oldlist);\n', dirfile, pattern, max_depth);
              % Call recursively the function in this subdirectory
              nbfiles = IO_DirGetFiles(dirfile, pattern, max_depth, fileId, nbfiles);
           end 
       end 
    end

    
end

