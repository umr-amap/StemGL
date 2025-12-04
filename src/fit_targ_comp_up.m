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

function [WDAT,NbMes] = fit_targ_comp_up(T,TQo,TQ,WDAT,NbMes)
% function [WDAT,NbMes] = fit_targ_comp_up(T,TQo,TQ,WDAT,NbMes)
%  Extracting Global compartment organ from simulation 
%   I    T:                 int    Number of cycles 
%   I    TQo(T)             int    Measurment value indicator
%   I    TQ(T)              double Measurment value
%   I-0  WDAT(NbMes):       double Measurment value
%   I-0  NbMes:             int    Number of Measurements
%
%   Last version 2018/11/22. Main author PdR/MJ   Copyright Cirad-AMAP
%

    for i = 1 : T
        if TQo(i) ~= 999  &&  TQo(i) ~= 0 
            WDAT(NbMes) = TQ(i);
            NbMes = NbMes + 1;
        end
    end
end