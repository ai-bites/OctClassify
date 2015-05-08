%% OCT PCA Test

file = load('data/Farsiu_Ophthalmology_2013_AMD_Subject_1240');

imgs = file.images;

kernelsize = [9 9];
patches_count = 1200; % Watch out when setting it to 12,000 

% generate random interest points
[w,h,scan_count] = size(imgs(:,:,:));
kernelsizehalfw = fix(kernelsize(1)/2);
kernelsizehalfh = fix(kernelsize(2)/2);
xs = randi([1+kernelsizehalfw,w-kernelsizehalfw],1,patches_count)';
ys = randi([1+kernelsizehalfh,h-kernelsizehalfh],1,patches_count)';
scan_indicies = randi([1,scan_count],1,patches_count)';
points = [xs,ys,scan_indicies];

% Extract patches
tic; patches = octextractpatches(imgs, points, kernelsize); toc;
% Run PCA
tic; [V,D]=octpca(patches,9); toc