%% Zack Humphries
% COMP 521
% HW1 Problem 3

clc;       % clear command window
clear;     % removes all saved variables
close all; % close any open windows


%% Case 1:
case_1_a = [1,2,-1;6,-5,4;-9,8,-7];
case_1_b = [2*pi; 5*pi; (-8)*pi];

[case_1_a_return, indx_1,d_1] = algorithm_1(case_1_a, 3);

[case_1_a_final,case_1_indx_final,case_1_X_final] = algorithm_2(case_1_a_return,case_1_b, 3, indx_1);


%% Case 2:
case_2_a = [pi,3*pi,2*pi;0,1,(-2/3);(-1*pi),(-3*pi),2*pi];
case_2_b = [3; 0; -1];

[case_2_a_return, indx_2,d_2] = algorithm_1(case_2_a, 3);

[case_2_a_final,case_2_indx_final,case_2_X_final] = algorithm_2(case_2_a_return,case_2_b, 3, indx_2);

%% Results

case_1_X_final

case_2_X_final


%% Algorithm 1
function [a,indx,d] = algorithm_1(a, n)
    
    vv = 1:n;
    d=1.0;
    iimax = 0.0;
    indx = [];

    for ii=1:n
        big=0.0;
        for j=1:n
            temp=abs(a(ii,j));
            if (temp > big)
                big = temp;
            end
        end
        if big == 0.0
            disp("rip");
            break
        end
        vv(ii)= 1.0/big;
    end

    for j=1:n
        for ii=1: (j-1)
            sum = a(ii,j);
            for k=1: (ii-1)
                sum = sum - a(ii,k)*a(k,j);
            end
            a(ii,j) = sum;
        end
        big=0.0;

        for ii=j:n
            sum=a(ii,j);
            for k=1: (j-1)
                sum = sum - (a(ii,k)*a(k,j));
            end
            a(ii,j) = sum;
            dum = vv(ii)*abs(sum);
            if dum >= big
                big = dum;
                iimax = ii;
            end
        end

        if j ~= iimax
            for k=1: n
                dum = a(iimax,k);
                a(iimax,k) = a(j,k);
                a(j,k)= dum;
            end
            d = -1*d;
            vv(iimax) = vv(j);
        end

        indx(j) = iimax;
        if a(j,j) == 0.0
            a(j,j) = 0.00001;
        end

        if j ~= n
            dum = 1.0/(a(j,j));
            for ii=(j+1):n
                a(ii,j) = a(ii,j)*dum;
            end
        end
    end
end

%% Algorithm 2
function [a,indx,b] = algorithm_2(a,b,n, indx)
    iii=0;
    sum = 0.0;

    for ii=1:n
        ip=indx(ii);
        sum = b(ip);
        b(ip)=b(ii);
        if iii
            for j=iii:(ii-1)
                sum = sum - a(ii,j)*b(j);
            end
        elseif sum
            iii=ii;
        end
        b(ii)=sum;
    end
    for ii=n:-1:1
        sum=b(ii);
        for j=(ii+1):n
            sum = sum - a(ii,j)*b(j);
        end
        b(ii) = sum/(a(ii,ii));
    end
end