%% MAIN Program for HW 3
% COMP 521
%
% 1) Calculate the finite difference approximation for the second
%    derivative of a function f(x) on the interval x \in [ 0.4 , 1]
% 2) Determine the order of accuracy of the finite difference
%    approximation using:
%
%   2.1) Absolute error of the midpoint
%   2.2) The root mean square error of the approximation
%   2.3) The infinity norm
%
%   You have to plot the error metrics versus 4 different grid sizes for
%   each case 2.1, 2.2, 2.3. Use loglog plot. Fit the points in the loglog
%   plot to a straight line using polyfit.
%
close all; 
%clear all; 
%clc; 

% Use the following grid sizes
h = [ 0.1 ; 0.05 ; 0.025 ; 0.0125];

% Calculate the number of grid sizes
m = size( h , 1 );

% Specify the Interval
x = [ 0.4 ; 1];

% Initialize an array with the error metrics
errorh = zeros( m , 3 );

% Calculate teh approzimation error for different grid sizes

for i = 1:m
    
    % Apply finite difference approximation
    [ xgrid, Dapprox, aproxlim ] = secderivativeapprox( x, h(i), @Fx );
    
    % Calculate exact solution at the ggrid points
    Dactual = secderivativeactual( xgrid );
    Dactual = Dactual(3:(length(Dactual)-2));       % Because we are ignoring the first 2 and last 2 indexes
    
    % Calculate the error vector
    % Note: Only inlcude the grid points in which tthe approximation was 
    %       computed
    Error = abs( Dapprox - Dactual );
    %Error_rmse = sqrt(Error.*Error/(length(Error)));
    Error_rmse = sqrt(mean((Dapprox-Dactual).^2));
    
    % Calculate the error metrics
    
    % For the midpoint INDEX!!
    impoint = round( ( x(2) - x(1) ) / ( 2*h(i))) + 1;
    
    % Show the midpoint you are using for the current grid to verify
    % that you are using the same x at each h
    fprintf('Midpoint for h=%11.10f is x=%11.10f \n',h(i),xgrid(impoint));
    
    % Save error at midpoint
    errorh(i,1) = Error(impoint-2);
    
    %% This area needs to be coded by you
    % For the rmse
    errorh(i,2) = Error_rmse ;
    
    % For the infinity norm
    errorh(i,3) = max(Error);
    
end

% Plot your results
% Please improve this to make pretty graphs!!

tiledlayout(3,1);

nexttile
loglog(h, errorh(:,1), 'b*'); grid; grid minor;
hold on
loglog(h, errorh(:,1), 'b-')
xlabel('Grid size [h]'); ylabel('|Error_{mid}|');
hold off

nexttile
loglog(h, errorh(:,2), 'r*'); grid; grid minor;
hold on
loglog(h, errorh(:,2), 'r-')
xlabel('Grid size [h]'); ylabel('|Error RSME_{mid}|');
hold off

nexttile
loglog(h, errorh(:,3), 'g*'); grid; grid minor;
hold on
loglog(h, errorh(:,3), 'g-')
xlabel('Grid size [h]'); ylabel('|Error Infinity|');
hold off


% Verify with linear plot fitting
disp(' ' );
% Midpoint Error
Efit = polyfit( log(h), log(errorh(:,1)),1);
disp(['Midpoint: Fit is |E| = ' num2str(Efit(1)) '*h + (' num2str(Efit(2)) ')' ]);

%% You need to code the following parts
% RMSE Error
% Put code here
Efit = polyfit( log(h), log(errorh(:,2)),1) ;
disp(['RMSE: Fit is |E| = ' num2str(Efit(1)) '*h + (' num2str(Efit(2)) ')' ]);

% Infintiy Error
% Put code here
Efit = polyfit( log(h), log(errorh(:,3)),1) ;
disp(['Infinity: Fit is |E| = ' num2str(Efit(1)) '*h + (' num2str(Efit(2)) ')' ]);
