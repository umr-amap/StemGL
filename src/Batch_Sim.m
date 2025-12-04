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


function[]= Batch_Sim ()

    startcputime = cputime; %cputime start

    %Generate the file with all output messages
    str = sprintf('Batch_Sim_%s.txt', datestr(now,'yyyy-mm-dd_HHMM'));
    diary(str);

    AGRO_PLANT = 1;
    PMA18 = 1;
    VIRTUAL_PLANT = 1;


    if AGRO_PLANT > 0

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_arabido\arabido37_comp4_phy4.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_beetroot\01beetroot64_comp_phyt.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_beetroot\02beetroot64_comp.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_beetroot\1beetroot64_comp_phyt.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_beetroot\2beetroot64_comp.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_coffea\coffea_canephora12_phyt.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_coffea\coffea_liberica9_phyt.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_coffea\coffea_racemosa29_phyt.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_coton\1cotton27_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_coton\2cotton27_comp5_phyt5.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_coton\3cotton27_comp5_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_cucumber\1cucumb31_comp3_phyt3.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_cucumber\2cucumb31_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_cucumber2\1cucumb31_comp3_phyt.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_cucumber2\2cucumb31_phyt.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_houblon\houblon25_phyt2.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_lettuce\lettuce36_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_maize\1maize30_comp1_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_maize\2maize30_comp5_phyt5.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_maize\3maize30_comp5_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_maize\4maize30_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_maize\5maize30_comp5.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_maize\6maize30_999_comp5_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_rice\1rice18_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_rice\2rice29_comp8.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_rice\3rice29_comp8_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_sunflower\1_sunflow120_comp5_phyt5.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_sunflower\2_sunflow63__phyt3.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_tomate\0tomat28_nz_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_tomate\1tomat28_zz_comp3phyt3.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_tomate\2tomat28_zz_phyt1.par');

        StemGL_Sim ('-i','..\data\Agro_Plant\agro_tomate\3tomat28_zz_comp1phyt1.par');

    end

    if PMA18 > 0

        %StemGL_Sim ('-i','..\data\PMA18\PMA18_0tomat28_fit2.par');

        StemGL_Sim ('-i','..\data\PMA18\PMA18_0tomat28_fit.par');

        StemGL_Sim ('-i','..\data\PMA18\PMA18_1tomat28.par');

        StemGL_Sim ('-i','..\data\PMA18\PMA18_2tomat28_expansion.par');

        StemGL_Sim ('-i','..\data\PMA18\PMA18_3tomat28_puits.par');

        StemGL_Sim ('-i','..\data\PMA18\PMA18_4tomat28_puits.par');

    end

    if VIRTUAL_PLANT > 0
        StemGL_Sim ('-i','..\data\Virtual_Plant\climate\lt_01_clim_hyd_vidage.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\climate\lt_02_clim_hyd_remplissage_vidage.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\climate\lt_03_clim_hyd_period.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\climate\lt_04_clim_hyd_stocha.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\climate\lt_05_clim_E_Mods.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\climate\lt_05_clim_E_Sp1.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\Expansion_delay\Delay01_Root_eq.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\Expansion_delay\Delay02_Rings.par');

        %StemGL_Sim ('-i','..\data\Virtual_Plant\Expansion_delay\Delay03_msk_Fruit_25.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\Expansion_delay\Delay03_msk_Fruit.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\Expansion_delay\expan01_sinkvar.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\FreeGrowth_equi\eq_01_ta5_tx5.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\FreeGrowth_equi\eq_02_w_abort_ta5_tx5.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\FreeGrowth_equi\eq_03_ta4_tx3_2bld_6fr.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\FreeGrowth_equi\eq_04_Eo_Qo_aQo.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\FreeGrowth_equi\eq_05_E1_Qo_aQo.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\FreeGrowth_equi\eq_06_lbd1_rings.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\FreeGrowth_equi\eq_07_root.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\LimitedGrowth_Sp\lt_01_Sp.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\LimitedGrowth_Sp\lt_02_Sp_root_fruit.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\LimitedGrowth_Sp\lt_03_lbd0_rings.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\LimitedGrowth_Sp\lt_04_lbd1_rings.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\LimitedGrowth_Sp\lt_05_lbd05_rings.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\MaskforPlant\msk_01_TermFlow.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\MaskforPlant\msk_02_zigzag.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\Pool\pool_b005_Sp.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\Pool\pool_w010_Sp.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\Pool\pool_w025_Sp.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\RandomPlant\rnd_eq_01_b.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\RandomPlant\rnd_eq_02_b_w_ring.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\RandomPlant\rnd_lt_03_bf_F.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\RandomPlant\rnd_lt_04_b_bf.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\Remobilisation\1remob.par');

        StemGL_Sim ('-i','..\data\Virtual_Plant\Remobilisation\2remob.par');
    end

    fprintf (1,'\nSCRIPT TOTAL CPU TIME    %f\n', cputime-startcputime);

    diary off
end
