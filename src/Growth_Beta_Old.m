function [F_S] = Growth_Beta_Old(n,tx,Bo1,Bo2)
%F_O: BETA LAW
F_O = zeros(n,n+1);F_S = zeros(n,n+1);
for i=1:n
    for x =1:tx(i,1)
        F_O(i,x) = ((x-0.5) / tx(i,1)) ^ (Bo1 - 1)...
            * (1 - (x-0.5) / tx(i,1)) ^ (Bo2 - 1) * (1 / tx(i,1));
    end

    %extracting the biggest class
    S =max(F_O(i,:));
    %computing classes and cumulating function
    for x = 1:tx(i,1) 
        F_O(i,x) =F_O(i,x) / S;
    end
    F_S(i,1:n+1)= F_O(i,1:n+1);
end
xx=0;
