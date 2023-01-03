function foutput = Fx( xin )
% This function evaluates a function f(x) at a given set of inputs x
%
% Inputs:
% xin : x values at which the function is evaluated
%
% Outputs:
% foutput : the results of f(xin)

% *********************************************************************** %
% *********************************************************************** %
% Evaluate the function at xin, assign the result to foutput
%
% Write your code here

length_xin = length(xin);
foutput = zeros(1, length_xin);

for i=1:length_xin
    foutput(i) = xin(i)^2-cos(10*xin(i));
end

% *********************************************************************** %
% *********************************************************************** %

end