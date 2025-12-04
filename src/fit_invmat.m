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

function [WDD] = fit_invmat(npar, WPADER)
%double(WDD);

    % initialisation
    WDD = zeros(npar,npar);
    WPP = zeros(npar);
    for i = 1 :  npar
        WDD(i,i) = 1; 
    end
    
    % invert matrix WPADER^-1 -->WDD
    for k = 1 : npar - 1
        for i = k + 1 : npar
            if WPADER(k,k) == 0
                mess_err = sprintf('ERROR on Matrix inversion. Diagonal term WPADER(k,k) is zero: i:%g %f\n', k, WPADER(k,k));
                error_message (100, 1, 'fist_lsqr_main', mess_err);
            else
                Wik_Wkk = WPADER(i,k) / WPADER(k,k);
                for l = 1 : npar
                    WDD(i,l) = WDD(i,l) - WDD(k,l) * Wik_Wkk;
                end
                for j = npar : -1 : k 
                    WPADER(i,j) = WPADER(i,j) - WPADER(k,j) * Wik_Wkk;
                end
            end
        end
    end
    
    for k = 1 : npar
        for i = npar : -1 : 1
            s = 0;
            for j = i : npar
                s = s + WPADER(i,j) * WPP(j);
            end
            WDD(i,k) = (WDD(i,k) - s) / WPADER(i,i);
            WPP(i) = WDD(i,k);
        end
        for i = 1 : npar
            WPP(i) = 0;
        end
    end

end
