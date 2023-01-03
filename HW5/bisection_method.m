%% Zack Humphries
% COMP 521
% HW5

function [root, iterations, guess_list] = bisection_method(f, a,b, tolerance)
    iterations = 0;
    tol = 1;
    if ( f(a) == 0 )
        root = a;
        return;
    elseif ( f(b) == 0 )
        root = b;
        return;
    elseif ( f(a) * f(b) > 0 )
        fprintf('f(a) and f(b) do not have opposite signs');
        return;
    end

    guess_list=[];

    while (tol>tolerance)
        iterations = iterations+1;
        mid=(a+b)/2;
        fa=f(a);
        fb=f(b);
        fmid=f(mid);
        guess_list = [guess_list, mid];

        if (fa*fmid < 0)
            b=mid;
            tol = abs(fa-fmid);
        elseif (fb*fmid <0)
            a=mid;
            tol = abs(fb-fmid);
        elseif (fmid==0)
            root = mid;
            tol=0;
        else
            fprintf('f(a), f(b), and f(mid) all have the same sign\n');
            root = "N/A";
            return;
        end
        root = mid;
    end  
end

    



