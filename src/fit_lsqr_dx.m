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

function [XPAR,WPAR] = fit_lsqr_dx(NVAR,XPAR,WDPAR,WPAR,WDEVPAR,WEPAR,EQUI,NPAR,p,it)
%                 [XPAR,WPAR] = fit_lsqr_dx(NVAR,XPAR,WDPAR,WPAR,WDEVPAR,WEPAR,EQUI,NPAR,pass,iter);
% matrix for computing least square method  ????
%global WPAR WDPAR WEPAR EQUI WDEVPAR XPAR 

%ARRAY DIMENSION
% Compute X + dX for the chosen variables
if it == 2
   for i = 1 : NPAR
      WPAR(i,2) = WPAR(i) + WDEVPAR(i);
   end
end
if it > 2 
   % New value of choosen parameter after a iteration
   for i = 1 : NPAR
      WPAR(i,it) = WPAR(i, it - 1) + WDPAR(i);% going toward target
   end
end
% Link between chosen parameters and the whole set 
k = 1;
for i = 1 : NVAR
   if XPAR(i) > 0
      XPAR(i,3) = WPAR(k,it);
      k = k+1;
   end
end 

if p > 1
   for z = p-1:NVAR
      if EQUI(z) == p-1 && XPAR(z) == 1% % for the derivative x+dx
         XPAR(z,3) = XPAR(z,3) + WEPAR(p-1);%Warning may be XPAR(z,2) is ok
      end
   end
end
