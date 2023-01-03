function Dactual = secderivativeactual( xgrid )
% Function that evaluates the exact second derivative of a function f(x)
% on a set of grid points
%
% Inputs:
% xgrid : x points at which the second derivative is evaluated
%
% Outputs:
% Dactual : second derivative values at the grid points


% *********************************************************************** %
% *********************************************************************** %
% Write you code here

length_x_grid = length(xgrid);

Dactual = zeros(1, length_x_grid);

for i=1:length_x_grid
    Dactual(i) = 100*cos(10*xgrid(i))+2;
end

end