%% HW 7
% Zachary Humphries
% COMP 521
% Fall 2022

clc
clear
close all

%% Problem 1

a = -2;         % Left Boundary (x)
b = 10;         % Right Boundary (x)

T = 8;          % Final Time
plot_list = [T/4, T/2, 3*T/4, T];

dx_list = [0.5^7, 0.5^8, 0.5^9, 0.5^10];
dt = dx_list(end)/2;   % To meet condition of |r| <= 1
error_list = zeros(length(dx_list), 1);

for i=1:length(dx_list)
    dx = dx_list(i);
    xgrid_short = [a+dx:dx:b-dx];
    xgrid_long = [a:dx:b];
    
    ICV = xgrid_short';
    ICV = problem1_u0(ICV);

    left_boundary = 0;
    right_boundary = 0;

    r=dt/dx;

    U = ICV;

    actual = problem1_u0(0-xgrid_long);

    figure(1+(5*(i-1)))
    plot([a xgrid_short b], [left_boundary U' right_boundary] , 'o-')
    hold on
    plot([xgrid_long], [actual] , 'r-')
    axis([a b -0.1 1.1])
    str = sprintf('Problem 1 Lax-Friedrichs \t dx = %.5f t = %.2f', dx, 0.0);
    title(str)
    xlabel('x')
    ylabel('U')
    hold off

    A = problem1_matrix(a,b,dx,dt);

    for dt_j = dt: dt : T
        left_boundary = problem1_u0(-2-dt_j);
        right_boundary = problem1_u0(10-dt_j);


        U(1) = U(1);
        U(end) = U(end);

        U = A*U;

        actual = problem1_u0(dt_j-xgrid_long);
        for k=1:length(plot_list)
            if (dt_j == plot_list(k))
                figure(1+k+(5*(i-1)))
                plot([a xgrid_short b], [left_boundary U' right_boundary] , 'o-')
                hold on
                plot([xgrid_long], [actual] , 'r-')
                axis([a b -0.1 1.1])
                str = sprintf('Problem 1 Lax-Friedrichs \t dx = %.5f t = %.2f', dx, dt_j);
                title(str)
                xlabel('x')
                ylabel('U')
                hold off
                pause(0.1)
            end
        end
    end
    index_actual = find(xgrid_long(1, :) == 8);
    index_U = find(xgrid_short(1, :) == 8);
    error_list(i,1) = abs(U(index_U,1) - actual(1,index_actual));
end

figure
forward_poly = polyfit(log(dx_list), log(error_list), 1);
loglog(dx_list, error_list, "o-"); grid on;
title("Problem 1 Error")
subtitle_name_forward = strcat("$\log(Error) = ", sprintf("%2.6f", forward_poly(1)), "\log(\Delta x) + ", sprintf("%2.6f", forward_poly(2)), "$");
subtitle(subtitle_name_forward,'interpreter','latex')
xlabel("$\log(\Delta x)$",'interpreter','latex')
ylabel("$\log(Error)$",'interpreter','latex')



function A = problem1_matrix(a,b,dx,dt)
    r = dt/dx;
    m = (b-a)/dx;
    one = ones(m-1,1);
    diag1 = (1+r)/2 * one;
    diag2 = (1-r)/2 * one;

    A = spdiags([diag1 zeros(m-1,1) diag2],-1:1,m-1,m-1);
    A = sparse(A);
end

function u0x = problem1_u0(x)
    u0x = zeros(size(x));
    for i=1:length(x)
        if abs(x(i)) <1
            u0x(i) = 1-abs(x(i));
        else
            u0x(i) = 0;
        end
    end
end