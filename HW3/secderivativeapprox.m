function [ xgrid, Dapprox, aproxlim ] = secderivativeapprox(x, h, Fx )
% This function implements the finite difference approximation of the
% second derivative of a function f(x)
%
% Inputs:
% x   : the X interval
% h   : the step size
% Fx  : handle to the function f(x)
%
% Outputs:
% xgrid     : The grid points in X
% Dapprox   : The finite difference approximation at the grid points
% aproxlim  : The indices of the interval endpoints where the approximation
%             is calculated

% Create the vector with the grid points
xgrid = x(1):h:x(2);

% Set the approximation limits. These limits depend on the finite
% difference approximation you will use.
% Note: In this example we cannot include the first and last endpoints
% into the approximation

firstendpoint = 3;              % Since we rely on ui-2 and u+2, the first usable point is 3
lastendpoint = length(xgrid)-2; % Since we rely on ui-2 and u+2, the last usable point is N-2


% *********************************************************************** %
% *********************************************************************** %
% Initialize the array approxlim
% * approxlim(1) : is the index of the first grid point where the finite
%                  difference is calculated
% * aproxlim(2) : is the index of the last grid point where the finite
%                 difference is calculated
%
% Write your code here
aproxlim = [firstendpoint,lastendpoint];




% *********************************************************************** %
% *********************************************************************** %

% Initialize the vector that will have the approximation
Dapprox = zeros(1, (lastendpoint-firstendpoint+1)); % +1 because Matlab indexes at 1
% You have to modify this part


% *********************************************************************** %
% *********************************************************************** %
% Now calculate the finite difference approximation
%
% Write your code here
x_grid_foutput = Fx(xgrid);         % returns f(x) for all x values on xgrid

length_Dapprox = length(Dapprox);
for i=1:length_Dapprox 
    Dapprox(i) = ((-1*x_grid_foutput(i))+(16*x_grid_foutput(i+1))-(30*x_grid_foutput(i+2))+(16*x_grid_foutput(i+3))+(-1*x_grid_foutput(i+4)))/(12*(h^2));
    % i = u(i-2), i+1 = u(i-1), i+2 = u(i), i+3 = u(i+1), i+4 = u(i+2)
    % Did that because Dapprox and x_grid_foutput are shifted by 2
end

end