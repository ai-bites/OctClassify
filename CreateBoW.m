
%% using K-means clustering, creates the codebook
% as per the paper
k = 100;
% each row in C is a patch centroid
[idxs C] = kmeans(patches,k);


%% Patch occurance histogram - Bag of words

kernelsize = [9 9];
patches_count = 1200;

% get patches from another volume
filename = load('data/Farsiu_Ophthalmology_2013_AMD_Subject_1241');
curr_imgs = filename.images;

% generate random interest points
[w,h,scan_count] = size(curr_imgs(:,:,:));
kernelsizehalfw = fix(kernelsize(1)/2);
kernelsizehalfh = fix(kernelsize(2)/2);
xs = randi([1+kernelsizehalfw,w-kernelsizehalfw],1,patches_count)';
ys = randi([1+kernelsizehalfh,h-kernelsizehalfh],1,patches_count)';
scan_indicies = randi([1,scan_count],1,patches_count)';
points = [xs,ys,scan_indicies];

curr_patches = octextractpatches(curr_imgs, points, kernelsize);

%Do KNN for new patches
[knn_idxs D] = knnsearch( C, curr_patches')
% visualize the histogram
x = hist(knn_idxs,k);
% normalized histogram 
x_norm = x ./ sum(x);






