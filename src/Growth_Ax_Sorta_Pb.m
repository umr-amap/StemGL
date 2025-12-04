function [qas,qps,qics,qfs,qms]=...
    Growth_Ax_Sorta(T,Axdc,PBN,MiPBN,MxPBN,nf,pa,pp,pe,pc,pf,pm,pt,qat,qpt,qict,qft,qmt)
% if RandomSt ==0 it is simple ! no need stochastic processing
%[CN]=func_comb(T+1);%binome newtown

%%%%%%%%%%% UN SEUL FRUIT MALE ??????? (nm = 1 ????)  MJ NON A FAIRE


qas=zeros(T,T);
if pp >0
    qps=zeros(T,T);
else
    qps=0;
end
if pe >0
    nis=zeros(T,T);
    qics=zeros(T,T);
else
    qics=0;
end
if pf >0
    qfs=zeros(T,T);
    nfs=zeros(T,T);
else
    qfs=0;
    nfs=0;
end
if pm >0
    qms=zeros(T,T);
    nms=zeros(T,T);
else
    qms=0;
    nms=0;
end

%%%%%%%%%%%%%%%%%%%%%%
% List mode
%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%
% M O D E  L I S T
%%%%%%%%%%%%%%%%%
for i=1:T % for all age
    for j=1:i% exploration main structure
        Lo=sum(Axdc(j+1:i));
        j1 = i - Lo;
        qas(j1,i) = qas(j1,i)+qat(i,j);
        if pp >0
            qps(j1,i) = qps(j1,i)+qpt(i,j);
        end
        if pe >0
            qics(j1,i) = qics(j1,i)+qict(i,j);
        end
        nis(j1,i) = Axdc(j,1);
        if pf >0
            qfs(j1,i) = qfs(j1,i)+qft(i,j);
            nfs(j1,i) = Axdc(j,1)*sign(nf(j,1));
        end
        if pm >0
            qms(j1,i) = qms(j1,i)+qmt(i,j);
            nms(j1,i) = Axdc(j,1)*sign(nm(j,1));
        end
    end %j
end %i

% statistics for GL
one_xs = ones(T,T);

Sgnnis = sign(nis);
dnnis = abs(one_xs - Sgnnis); % so no more 0 for dividing
nis = nis + dnnis;
% average
qas = qas./(nis);
if pp > 0
    qps = qps./(nis);
end
if pe > 0
    qics = qics./(nis);
end
if pf > 0
    Sgnnfs = sign(nfs);
    %onenfxs = ones(T,T);
    dnnfs = abs(one_xs - Sgnnfs); % so no more 0 for dividing
    nfs = nfs + dnnfs;
    qfs = qfs./(nfs);
end
if pm > 0
    qms = qms./(nis);
end

% % To have the tip case of proba for rank according to negative binomial law
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sort phytomer and lateralstruct top down
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if pp ==0 qps =0; end
% if pe ==0 qpe =0; end
% if pf ==0 qfs =0; end
% if pm ==0 qms =0; end
if pe > 0
    qos = qics;
else
    qos = qas;
end

[qas,qps,qics,qfs,qms] = Growth_axPhytTopdown(T,PBN,MiPBN,MxPBN,qos,qas,qps,qics,qfs,qms,pp,pe,pf,pm);

if pe >0
    qtemp = qics;
else
    qtemp = qas;
end
[qas] = crunchq_downqo(qas,qtemp,T);
if pp > 0
    [qps] = crunchq_downqo(qps,qtemp,T);
end
if pe > 0
    [qics] = crunchq_downqo(qics,qtemp,T);
end
if pf > 0
    [qfs] = crunchq_downqo(qfs,qtemp,T);
end
if pm > 0
    [qms] = crunchq_downqo(qms,qtemp,T);
end
% conditionning phyt for out of range
for i = 1 : T-1
    for j = T-i : -1 : 1
        %if j ~= T-i+1 % -1 for out of range ...
            qas(j,i) = -1;
            if pp > 0
                qps(j,i) = -1;
            end
            if pe > 0
                qics(j,i) = -1;
            end
            if pf > 0
                qfs(j,i) = -1;
            end
            if pm > 0
                qms(j,i) = -1;
            end
        %end
    end
end
% conditioning pause and position of absent fruit
for i = 1 : T
    for j = T: -1 : T-i+1
        if qas(j,i) == 0
            qas(j,i) = -0.0001;
        end
        if pp > 0
            if qps(j,i) == 0
                qps(j,i) = -0.0001;
            end
        end
        if pe > 0
            if qics(j,i) == 0
                qics(j,i) = -0.0001;
            end
        end
        if pf > 0
            if qfs(j,i) == 0
                qfs(j,i) = -0.0001;
            end
        end
        if pm > 0
            if qms(j,i) == 0
                qms(j,i) = -0.0001;
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [qas,qps,qics,qfs,qms] = Growth_axPhytTopdown(...
    T,PBN,MiPBN,MxPBN,qox,qax,qpx,qicx,qfx,qmx,pp,pe,pf,pm)
%
% function [qas,qps,qics,qfs,qms] = Growth_axPhytTopdown(T,PBN,qox,qax,qpx,qicx,qfx,qmx,pp,pe,pf,pm)
%
%  
qas=zeros(T,T);
qps=zeros(T,T);
qics=zeros(T,T);
qfs=zeros(T,T);
qms=zeros(T,T);
%SPBN=zeros(T,T);

for i = 1 : T
    for k = 1 : i % because last internode has no struct!
        %ikk = i - k + 1;
        %kmi = max(MiPBN(k,1),k);
        %kma = min(MxPBN(k,1),i);
        %SPBN_ki = 0.0;
        %ikj = i - kmi + 1;
        %for  j = kmi : kma            
        %         
         ikk = i - k + 1;
         SPBN_ki = 0.0;
         ikj = ikk;
         for  j = k : i
            PBN_kj = PBN(k,j);
            if PBN_kj > 0 && qox(ikj,i) > 0 %%%% qis cannot exist if qix =0
                qas(ikk,i)= qas(ikk,i) + PBN_kj * qax(ikj,i);
                if pp > 0
                    qps(ikk,i)= qps(ikk,i) + PBN_kj * qpx(ikj,i);
                end
                if pe > 0
                    qics(ikk,i)= qics(ikk,i) + PBN_kj * qicx(ikj,i);
                end
                if pf > 0
                    qfs(ikk,i)= qfs(ikk,i) + PBN_kj * qfx(ikj,i);
                end
                if pm > 0
                    qms(ikk,i)= qms(ikk,i) + PBN_kj * qmx(ikj,i);
                end
                SPBN_ki = SPBN_ki + PBN_kj;
            end
            ikj = ikj - 1;
        end % j
         
        if SPBN_ki > 0 % if the branch  is limited SPBN can be <1
            qas(ikk,i) = qas(ikk,i) / SPBN_ki;
            if pp >0
                qps(ikk,i) = qps(ikk,i) / SPBN_ki;
            end
            if pe >0
                qics(ikk,i) = qics(ikk,i) / SPBN_ki;
            end
            if pf >0
                qfs(ikk,i) = qfs(ikk,i) / SPBN_ki;
            end
            if pm >0
                qms(ikk,i) = qms(ikk,i) / SPBN_ki;
            end
        end
    end % k
end % i