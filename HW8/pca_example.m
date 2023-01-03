%% Greyscale PCA
%
% Jared Brzenski

close all;
clear all;
clc
% Setup principal components to use. Pick 4.
principal_components = [1 10 50 100 200 300]
pics = length(principal_components);

% Read in image
I = imread('Z_Z.jpg'); 
% and convert to grayscale
I = rgb2gray(I);

% Show it
figure(1)
imshow(I, []);title('1440x1400 B&W Image: 2,073,600 pixels'); 

% Make data double precision
data = double(I);
%
[m n] = size(data);

% Find mean
mn   = mean(data,1);

% make data have zero mean, for covariance
data = data - repmat(mn,m,1);
fprintf('Now data has zero mean: %4.5f\n', (mean(mean(data))) );

% Find covariance of the data
covar_temp = cov(data);
%
% Or do it by hand....
% for y=1:n
%     for in=1:n
%             covar_temp(y,in)=1/((m*n)-1)*(data(:,y)' * data(:,in))  ;
%     end
% end
%
% Find eigen values and vectors, returns eigenvalues as vector
[PC, V] = eig(covar_temp, 'vector');

% Flip values and vectors to go from biggest to smallest
V  = flipud(V);
PC = fliplr(PC);

% OLD!!!: Rank and order the values and vectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Retain only the eigen values ( stored on the diagonal )
%V = diag(V);

% Rank the eigenvalues - backwards from given values
%[holder rank_indices] = sort(-1*V);

% Sort the eigen vectors based on the sorted eigenvalues
%V = V(rank_indices);
%PC = PC(:,rank_indices);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Loop over different PC sizes and plot them
pc = principal_components; 
figure(34); 
vsum = sum(V);
tiledlayout(3,2)
for pp = 1:pics
    % Extract the principal components we asked for
    output = PC(:,1:(pc(pp)))' * data';
    [xx yy] = size(output); ts = (xx+1)*yy;
    % Reconstruct full image from those principal components ( round for
    % greyscale values, need to be whole numbers )
    reconstruct = round((PC(:,1:(pc(pp)))*output) + repmat(mn,m,1)');

    % Show reconstructed image with n principal components
    nexttile
    imshow(reconstruct', []);
    title([num2str(pc(pp)) ' components, ' num2str((ts)/(m*n)*100) '%  storage, ' num2str(sum(V(1:pc(pp))/vsum)*100) '% eigen']);
end

figure(99)
    imshow(reconstruct', []);
    title([num2str(pc(pp)) ' components, ' num2str((ts)/(m*n)*100) '%  storage, ' num2str(sum(V(1:pc(pp))/vsum)*100) '% eigen']);
