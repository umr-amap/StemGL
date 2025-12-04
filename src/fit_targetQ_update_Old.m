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

function [WM,WPD,x]=fit_targetQ_update_Old(...
    pass,comp,T,mxTob,Tob,...
    moTQAt,moTQPt,moTQICt,moTQFt,moTQMt,moTQTt,...
    moqat,moqpt,moqict,moqft,moqmt,...
    TQAob,TQPob,TQICob,TQFob,TQMob,TQTob,...
    qaob,qpob,qicob,qfob,qmob,...
    pa,pp,pe,pc,pf,pm,pt,WDAT,WM,WPD)
x=1;
if comp(1,1) >0 % Global
    [WDAT,x]=fit_targ_comp_up(T,TQAob,moTQAt,WDAT,x);
    % storage of petiol compartment
    if pp >0
        [WDAT,x]=fit_targ_comp_up(T,TQPob,moTQPt,WDAT,x);
    end
    % storage of internode compartment
    if pe >0
        [WDAT,x]=fit_targ_comp_up(T,TQICob,moTQICt,WDAT,x);
    end
    % storage of female fruit compartment
    if pf >0 > 0
        [WDAT,x]=fit_targ_comp_up(T,TQFob,moTQFt,WDAT,x);
    end
    % storage of male fruit compartment
    if pm > 0
        [WDAT,x]=fit_targ_comp_up(T,TQMob,moTQMt,WDAT,x);
    end
    % storage of root compartment
    if pt >0
        [WDAT,x]=fit_targ_comp_up(T,TQTob,moTQTt,WDAT,x);
    end
end
if comp(1,2)>0 %phyt
    %for storage blade organ (met rank)
    [WDAT,WPD,x]= fit_targ_phyt_up(mxTob,Tob,T,qaob,moqat,WDAT,WPD,x);
    %for storage petiol organ (met rank)
    if pp >0
        [WDAT,WPD,x]= fit_targ_phyt_up(mxTob,Tob,T,qpob,moqpt,WDAT,WPD,x);
    end
    %for storage internode organ (met rank)
    if pe > 0
        [WDAT,WPD,x]= fit_targ_phyt_up(mxTob,Tob,T,qicob,moqict,WDAT,WPD,x);
    end
     %for storage female fruit organ (met rank)
    if pf > 0
        [WDAT,WPD,x]= fit_targ_phyt_up(mxTob,Tob,T,qfob,moqft,WDAT,WPD,x);
    end
    %for storage male fruit organ (met rank)
    if pm > 0
        [WDAT,WPD,x]= fit_targ_phyt_up(mxTob,Tob,T,qmob,moqmt,WDAT,WPD,x);
    end
end
% for rings if no ring put a small value
x=x-1;
% construction of target for lsqrm
for i = 1:x
    WM(i, 1+pass) = WDAT(i,1);
end
z=1;