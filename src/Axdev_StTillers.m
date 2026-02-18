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

function [Axdc,ni,na,np,nf,nm,Xas]= Axdev_StTillers(Krnd, Nrnd, AxdPot, T, Nrep_S, nao, npo, nfo, nmo, bf, TileNb,TilePb1,TileDelay1,TileDelay2,TileLgMax,TileDev1)
%
% function [Axdc,ni,na,np,nf,nm,Xas]= Axdev_StTillers(
%       Krnd, Nrnd, AxdPot, T, Nrep_S, nao, npo, nfo, nmo, bf, TileNb,TilePb1,TileDelay1,TileDelay2,TileLgMax,TileDev1)
%
% Computes Nrep_S development axis with theeir potential fruits
%   I   Krnd:       random generator congruence coefficient
%   I   Nrnd:       random generator current seed
%   I   AxdPot(T,1):Potential development axis
%   I   T:          Plant age
%   I   Nrep_S:     Number of stochastic repetitions
%   I   nao:        Maximum number of leafs per phytomer
%   I   npo:        Maximum number of petiol per phytomer
%   I   nfo:        Maximum number of female fruits per phytomer
%   I   nmo:        Maximum number of male fruits per phytomer
%   I   bf:         fruit occurence probability
%   I   TileNb:     Maximum number of tillers
%   I   TilePb1:    Tiller occurrence probability (simple)
%   I   TilePb2:    Tiller occurrence probability (secondary)
%   I   TileDelay1: Tiller apparence delay (fixed)
%   I   TileDelay2: Tiller apparence delay (variable)
%   I   TileLgMax:  Tiller max cycle number
%   I   TileDev1:   Tiller development probability (bernouilly)
%   I   TileDev2:   Tiller development probability 2
%   I   TileRes:    Tiller supplementary parameter
%   O   Axdc(T,Nrep_S): Development axis
%   O   ni(T,Nrep_S):   Number of internodes
%   O   na(T,Nrep_S):   Number of leaves
%   O   np(T,Nrep_S):   Number of petiols
%   O   nf(T,Nrep_S):   Number of female fruits
%   O   nm(T,Nrep_S):   Number of male fruits
%   O   Xas(T):         Number of axis distribution
%

    Xas  = zeros(T,1);    % distribution of phytomers (simulations)
    Axdc = zeros(T,Nrep_S); % development axis
    ni = zeros(T,Nrep_S);   % internode development axis (should be equal to Axdc)
    na = zeros(T,Nrep_S);   % leaf development axis (number of leaves per cycle)
    np = zeros(T,Nrep_S);   % petiol development axis (number of petiol per cycle)
    nf = zeros(T,Nrep_S);   % fruit female development axis (number of female fruits per cycle)
    nm = zeros(T,Nrep_S);   % fruit male development axis (number of male fruits per cycle)

    if TileLgMax > T || TileLgMax < 1
      Tilelmax = T;
    else
      Tilelmax = TileLgMax;
    end

    Nrnd1 = Krnd*Nrnd - floor(Krnd*Nrnd);
    for s = 1 : Nrep_S %% N random simulations of axis
        % simule law of development Bernouilly process Axdc( 1 0 0 1 1 0,...)
        for tile = 0 : TileNb %(tile 0 is the main stem)
            len = 0; %axis length
            Nrnd1 = Krnd*Nrnd1 - floor(Krnd*Nrnd1);
            Nrnd = Krnd*Nrnd - floor(Krnd*Nrnd);
            % Check if tiller or not
            %fprintf(1, '\n Tile %d on %d \n', tile, TileNb);
            if tile > 0
                if Nrnd <= TilePb1 % tiller exists, use specific delay
                    Nrnd = Krnd*Nrnd - floor(Krnd*Nrnd);
                    delay = TileDelay1 + floor(Nrnd*TileDelay2*(Tilelmax-TileDelay1));
                    %fprintf(1, '\n Tile %d on %d . Delay %d\n', tile, TileNb, delay);
                    for i = 1 : Tilelmax
                        % generating random number series
                        Nrnd = Krnd*Nrnd - floor(Krnd*Nrnd);
                        if i > delay && Nrnd <= TileDev1 % phytomer exists
                            len = len + 1;
                            Axdc(i,s) = Axdc(i,s) + 1;
                            ni(i,s) = ni(i,s) + 1;
                            na(i,s) = na(i,s) + nao;
                            np(i,s) = np(i,s) + npo;
                            nm(i,s) = nm(i,s) + nmo;
                            %% fruit stochastic
                            n = 0;
                            for z = 1 : nfo
                                Nrnd1 = Krnd*Nrnd1 - floor(Krnd*Nrnd1);
                                if Nrnd1 <= bf   % fruit exists
                                    n = n + 1;
                                end
                            end
                            nf(i,s) = nf(i,s) + n;
                            %end
                        end
                    end
                    if len > 0
                        Xas(len,1) = Xas(len,1) + 1;  % Updates the distribution (there is a new axis of len phytomers)
                    end
                end
            else % main stem
                for i = 1 : T
                    % generating random number series
                    Nrnd = Krnd*Nrnd - floor(Krnd*Nrnd);
                    if Nrnd <= AxdPot(i,1) % phytomer exists
                        len = len + 1;
                        Axdc(i,s) = Axdc(i,s) + 1;
                        ni(i,s) = ni(i,s) + 1;
                        na(i,s) = na(i,s) + nao;
                        np(i,s) = np(i,s) + npo;
                        nm(i,s) = nm(i,s) + nmo;
                        n = 0;
                        for z = 1 : nfo
                            Nrnd = Krnd*Nrnd - floor(Krnd*Nrnd);
                            if Nrnd <= bf   % fruit exists
                                n = n + 1;
                            end
                        end
                        nf(i,s) = nf(i,s) + n;
                    end
                end
                if len > 0
                    Xas(len,1) = Xas(len,1) + 1;  % Updates the distribution (there is a new axis of len phytomers)
                end
            end
        end
    end
end
