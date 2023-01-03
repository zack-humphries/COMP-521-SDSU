%% HW 7
% Zachary Humphries
% COMP 521
% Fall 2022

clc
clear
close all

%% Problem 2

a = 0;         % Left Boundary (x)
b = 1;         % Right Boundary (x)

T = 0.1;          % Final Time

%% a)

dx_list = 0.2;
dt = 0.02;

estimated_U = zeros(length([0:dt:T]), length([a:dx_list:b]));
actual_U = zeros(length([0:dt:T]), length([a:dx_list:b]));


for i=1:length(dx_list)
    dx = dx_list(i);
    xgrid_short = [a+dx:dx:b-dx];
    xgrid_long = [a:dx:b];
    
    ICV = xgrid_short';
    ICV = problem2_u0(ICV,0);

    left_boundary = 0;
    right_boundary = 0;

    r=dt/(dx^2);

    U = ICV;
    estimated_U(1, :) = [left_boundary U' right_boundary];

    actual = problem2_u0(xgrid_long, 0);
    actual_U(1, :) = actual;

    A = problem2_matrix(a,b,dx,dt);

    count = 2;

    for dt_j = dt: dt : T

        U(1) = U(1);
        U(end) = U(end);

        U = A*U;

        actual = problem2_u0(xgrid_long, dt_j);
        actual_U(count, :) = actual;

        estimated_U(count, :) = [left_boundary U' right_boundary];
        
        count = count +1;
    end
end

[X_mesh, T_mesh] = meshgrid([a:dx:b] , [0:dt:T]);


mesh(X_mesh, T_mesh, estimated_U, 'FaceColor','b', 'EdgeColor', "k")
title([sprintf('Problem 2 Numerical Solution for dx = %.2f dt = %.2f', dx_list, dt)])
xlabel('x')
ylabel('t')
zlabel('U')
axis([a b, 0, T, -0.1 1.75])
drawnow

figure
mesh(X_mesh, T_mesh, (actual_U), 'FaceColor','r', 'EdgeColor', "k")
title([sprintf('Problem 2 Exact Solution for dx = %.2f dt = %.2f', dx_list, dt)])
xlabel('x')
ylabel('t')
zlabel('U')
axis([a b, 0, T, -0.1 1.75])
drawnow

figure
mesh(X_mesh, T_mesh, (abs(actual_U-estimated_U)), 'FaceColor','texturemap', 'EdgeColor', "k")
title([sprintf('Problem 2 Error for dx = %.2f dt = %.2f', dx_list, dt)])
xlabel('x')
ylabel('t')
zlabel('U')
axis([a b, 0, T, -0.1 1.75])
colorbar
caxis([0, max(abs(actual_U-estimated_U), [], 'all')])
drawnow

%% b)

% If you want plots similar to (a), uncomment the code below

dx_list = [0.5^3, 0.5^4, 0.5^5, 0.5^6, 0.5^7];
dt = dx_list(end)^2/4;

error_list = zeros(length(dx_list), 1);

for i=1:length(dx_list)
    dx = dx_list(i);
    xgrid_short = [a+dx:dx:b-dx];
    xgrid_long = [a:dx:b];

%     estimated_U = zeros(length([0:dt:T]), length([a:dx:b]));
%     actual_U = zeros(length([0:dt:T]), length([a:dx:b]));
    
    ICV = xgrid_short';
    ICV = problem2_u0(ICV,0);

    left_boundary = 0;
    right_boundary = 0;

    r=dt/(dx^2);

    U = ICV;

    actual = problem2_u0(xgrid_long, 0);

%     actual_U(1, :) = actual;
% 
%     estimated_U(1, :) = [left_boundary U' right_boundary];

    A = problem2_matrix(a,b,dx,dt);

    count = 2;

    for dt_j = dt: dt : T

        U(1) = U(1);
        U(end) = U(end);

        U = A*U;

        actual = problem2_u0(xgrid_long, dt_j);

%         actual_U(count, :) = actual;
%         estimated_U(count, :) = [left_boundary U' right_boundary];

        count = count+1;
    end

    error_list(i,1) = abs(U(((length(U)+1)/2),1)-actual(1,((length(U)+1)/2)));



%     [X_mesh, T_mesh] = meshgrid([a:dx:b] , [0:dt:T]);
% 
%     figure
%     mesh(X_mesh, T_mesh, estimated_U, 'FaceColor','b')
%     title([sprintf('Problem 2 Numerical Solution for dx = %.5f dt = %.5f', dx, dt)])
%     xlabel('x')
%     ylabel('t')
%     zlabel('U')
%     axis([a b, 0, T, -0.1 1.75])
%     drawnow
%     
%     figure
%     mesh(X_mesh, T_mesh, (actual_U), 'FaceColor','r')
%     title([sprintf('Problem 2 Exact Solution for dx = %.5f dt = %.5f', dx, dt)])
%     xlabel('x')
%     ylabel('t')
%     zlabel('U')
%     axis([a b, 0, T, -0.1 1.75])
%     drawnow
%     
%     figure
%     mesh(X_mesh, T_mesh, (abs(actual_U-estimated_U)), 'FaceColor','texturemap', 'EdgeColor', "none")
%     title([sprintf('Problem 2 Error for dx = %.5f dt = %.5f', dx, dt)])
%     xlabel('x')
%     ylabel('t')
%     zlabel('U')
%     axis([a b, 0, T, 0, max(abs(actual_U-estimated_U), [], 'all')])
%     colorbar
%     caxis([0, max(abs(actual_U-estimated_U), [], 'all')])
%     drawnow

end

figure
forward_poly = polyfit(log(dx_list), log(error_list), 1);
loglog(dx_list, error_list, "o-"); grid on;
title("Problem 2 Error")
subtitle_name_forward = strcat("$\log(Error) = ", sprintf("%2.6f", forward_poly(1)), "\log(\Delta x) + ", sprintf("%2.6f", forward_poly(2)), "$");
subtitle(subtitle_name_forward,'interpreter','latex')
xlabel("$\log(\Delta x)$",'interpreter','latex')
ylabel("$\log(Error)$",'interpreter','latex')

function A = problem2_matrix(a,b,dx,dt)
    r = dt/(dx^2);
    m = (b-a)/dx;
    one = ones(m-1,1);
    diag1 = r * one;
    diag2 = (1-2*r) * one;

    A = spdiags([diag1 diag2 diag1],-1:1,m-1,m-1);
    A = sparse(A);
end

function u0x = problem2_u0(x, time)
    u0x = (sin(pi*x)*exp(-pi^2 *time))+(sin(3*pi*x)*exp(-9*pi^2 *time));
end