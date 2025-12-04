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

function [WDPAR,WDD,DY] = fit_lsqr_main(T,np,it,WM,WEPAR,WPD,WDD,WPAR,WDPAR)
WTEMP=zeros(250,1);WADER=zeros(T,np);WTADER=zeros(np,T);WPADER=zeros(np,np);
WXDIST=zeros(T,1);WYDIST=zeros(T,1);

%%REM derivatives computation
for k = 1 :T
   for i = 1 :np
      WADER(k, i) = (WM(k, i+2) - WM(k, 2)) / WEPAR(i,1);
   end
end
%REM computing distance from target
for i = 1:T
   WYDIST(i,1) = WM(i, 1+0) - WM(i, 1+1);
end
%REM compute WADER t
for i = 1:T
   for j = 1:np
      WTADER(j, i) = WADER(i, j);
   end
end
for i = 1:np
   for j= 1:np
      WPADER(i, j) = 0;
      for k = 1:T% REM nb de pts
         WPADER(i, j) = WPADER(i, j) + WTADER(i, k)* WPD(k,1) * WADER(k, j);
      end
   end
end
%REM invert WPADER inversion  matrix WCC^-1 -->D
LL = np;
WDD = fit_invmat(LL, WPADER);
%REM calcul  des WXDIST
%REM product  WTADER  * WYDIST
for i = 1 :np
   WTEMP(i,1) = 0;
   for j = 1 :T% REM of de pts
      WTEMP(i,1) = WTEMP(i,1) + WTADER(i, j) * WYDIST(j)* WPD(j,1) ;
   end
end

for i = 1 :np
   WXDIST(i,1) = 0;
   for j = 1 :np
      WXDIST(i,1) = WXDIST(i,1) + WDD(i, j) * WTEMP(j,1);
   end
end

DX = 0;
for i = 1:np
   DX = DX + abs(WXDIST(i,1)) / WPAR(i, it);
   WDPAR(i,1) = WXDIST(i,1);
end

DY = 0;
for i = 1 :T
   DY = DY +  WPD(i,1)*WYDIST(i,1) ^ 2;
end
%DG(it) = DY;