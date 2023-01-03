%% Zack Humphries
% COMP 521
% HW6

close all;
clear;
clc;

% Analytical solution == u(t) = cos(sqrt(2) * t)
% u(0) = 1
% u'(t) = 0

time = 10;
expo = [5 6 7 8 9];
time_steps = 1./2.^expo;

%%
forward_euler_error = zeros(length(time_steps),1);
backward_euler_error = zeros(length(time_steps),1);
trapezoid_error = zeros(length(time_steps),1);

for kk = 1:length(time_steps)
    
    dt = time_steps(kk);
    t_vec = [0 : dt : time]; 
    [forward_euler_U, Analytic, Error_forward] = forward_euler(dt, time);
    forward_euler_error(kk,1) = Error_forward;

    [backward_euler_U, Error_backward] = backward_euler(dt, time);
    backward_euler_error(kk,1) = Error_backward;

    [trapezoid_U, Error_trapezoid] = trapezoid(dt, time);
    trapezoid_error(kk,1) = Error_trapezoid;

    figure
    hold on
    plot(forward_euler_U(1,:), forward_euler_U(2,:));
    plot(backward_euler_U(1,:), backward_euler_U(2,:));
    plot(trapezoid_U(1,:), trapezoid_U(2,:), '-m');
    plot(Analytic(1,:), Analytic(2,:), '--g', "LineWidth",1);
    title_name = strcat("$\frac{du}{dt}$ vs $u$ Comparison Plot$: \Delta t = \left(\frac{1}{2}\right)^{", sprintf("%i", expo(kk)), "}$");
    title(title_name,'interpreter','latex')
    legend("Forward Euler", "Backwards Euler", "Trapezoidal", "Analytic")
    xlabel("$u$",'interpreter','latex')
    ylabel("$\frac{du}{dt}$",'interpreter','latex')
    % add a legend, label, etc, etc
    hold off
end

%% make plot

% Error plotting
figure
forward_poly = polyfit(log(time_steps), log(forward_euler_error), 1);
loglog(log(time_steps), log(forward_euler_error), "o-"); grid on;
title("Forward Euler Error")
subtitle_name_forward = strcat("$\log(Error) = ", sprintf("%2.6f", forward_poly(1)), "\log(\Delta t) + ", sprintf("%2.6f", forward_poly(2)), "$");
subtitle(subtitle_name_forward,'interpreter','latex')
xlabel("$\log(\Delta t)$",'interpreter','latex')
ylabel("$\log(Error)$",'interpreter','latex')
figure
backward_poly = polyfit(log(time_steps), log(backward_euler_error), 1);
loglog(log(time_steps), log(backward_euler_error), "o-"); grid on;
title("Backwards Euler Error")
subtitle_name_backward = strcat("$\log(Error) = ", sprintf("%2.6f", backward_poly(1)), "\log(\Delta t) + ", sprintf("%2.6f", backward_poly(2)), "$");
subtitle(subtitle_name_backward,'interpreter','latex')
xlabel("$\log(\Delta t)$",'interpreter','latex')
ylabel("$\log(Error)$",'interpreter','latex')
figure
trapezoid_poly = polyfit(log(time_steps), log(trapezoid_error), 1);
loglog(log(time_steps), log(trapezoid_error), "o-"); grid on;
title("Trapezoidal Method Error")
subtitle_name_trapezoid = strcat("$\log(Error) = ", sprintf("%2.6f", trapezoid_poly(1)), "\log(\Delta t) + ", sprintf("%2.6f", trapezoid_poly(2)), "$");
subtitle(subtitle_name_trapezoid,'interpreter','latex')
xlabel("$\log(\Delta t)$",'interpreter','latex')
ylabel("$\log(Error)$",'interpreter','latex')

% HW asks for global trunc error and last time step

%% Forward Euler Function

function [U, Analytic, Error] = forward_euler(dt, time)
    steps = time/dt;
    t_vec = [0 : dt : time]; 
    U = zeros(2,steps+1);
    Analytic = zeros(2,steps+1);
    
    % Set initial condition
    U(:, 1) = [1 ; 0];
    
    % finite difference Matrix
    F = [1      dt;...
        -2*dt   1];
    
    % looop over all time steps
    for ii=2:steps
        U(:, ii) = F * U(:,ii-1);
    end
    
    Analytic (1,:) = analytic(t_vec);
    Analytic (2,:) = analyticdt(t_vec);

    Error = abs( U(1,(end+1)/2) - Analytic(1,(end+1)/2) );
end

%% Backwards Euler Function

function [U, Error] = backward_euler(dt, time)
    steps = time/dt;
    t_vec = [0 : dt : time]; 
    U = zeros(2,steps+1);
    Analytic = U;
    
    % Set initial condition
    U(:, 1) = [1 ; 0];
    
    % finite difference Matrix
    F = [1      -dt;...
         2*dt   1];
    
    % looop over all time steps
    for ii=2:steps
        U(:, ii) = inv(F)*U(:,ii-1);
    end
    
    Analytic (1,:) = analytic(t_vec);
    Analytic (2,:) = analyticdt(t_vec);

    Error = abs( U(1,(end+1)/2) - Analytic(1,(end+1)/2) ); 
end

%% Trapezoid Function

function [U, Error] = trapezoid(dt, time)
    steps = time/dt;
    t_vec = [0 : dt : time]; 
    U = zeros(2,steps+1);
    Analytic = U;
    
    % Set initial condition
    U(:, 1) = [1 ; 0];
    
    % finite difference Matrices
    F1 = [1      dt/2;...
         -dt     1];
    F2 = [1      -dt/2;...
         dt     1];
    
    % looop over all time steps
    for ii=2:steps
        U(:, ii) = inv(F2)*F1*U(:,ii-1);
    end
    
    Analytic (1,:) = analytic(t_vec);
    Analytic (2,:) = analyticdt(t_vec);

    Error = abs( U(1,(end+1)/2) - Analytic(1,(end+1)/2) ); 
end

function result = analytic(t)
    s2 = sqrt(2);
    result = cos(s2 .* t);
end

function result = analyticdt(t)
    s2 = sqrt(2);
    result = -s2 .* sin(s2 .* t);
end