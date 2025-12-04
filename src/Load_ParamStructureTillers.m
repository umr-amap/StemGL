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

function [TileNb,TilePb1,TilePb2,TileDelay1,TileDelay2,TileLgMax,TileDev1,TileDev2,TileRes] = Load_ParamStructureTillers (param, T_Age)
%
% function [TileNb,TilePb1,TilePb2,TileDelay1,TileDelay2,TileLgMax,TileDev1,TileDev2,TileRes] = Load_ParamStructureTillers (param, T_Age)
%
%   O   TileNb:     Maximum number of tillers
%   O   TilePb1:    Tiller occurrence probability (simple)
%   O   TilePb2:    Tiller occurrence probability (secondary)
%   O   TileDelay1: Tiller apparence delay (fixed) 
%   O   TileDelay2: Tiller apparence delay (variable)
%   O   TileLgMax:  Tiller max cycle number 
%   O   TileDev1:   Tiller development probability (bernouilly) 
%   O   TileDev2:   Tiller development probability 2
%   O   TileRes:    Tiller supplementary parameter
%   I   param:      the parameter table
%   I   p_Age:      plant age defined as an external argument
%
%   Last version 2025/09/26. Main author MJ
%   Copyright Cirad-AMAP
%
    %Tiller parameters are supposed to be defined in line 24 = thus at 25th position in the table
    TileNb = param(25,1);
    TilePb1 = param(25,2); TilePb2 = param(25,3); 
    
    TileDelay1 = param(25,4); TileDelay2 = param(25,5); 

    TileLgMax = param(25,6); TileDev1 = param(25,7); TileDev2 = param(25,8);
    TileRes = param(25,9); 
    
    % overwrite plant age
    if TileLgMax <= 0 || TileLgMax > T_Age
        TileLgMax = T_Age;
    end
    
    
end

