%% OCT Extract Patches
% Input
% imgs is a 3D matrix of size w by h by count
% w is number of row pixels
% h is number of column pixels
% count is number of images slices
% points is a 2D matrix of size n by 3
% n is number of points, it is expected to by 12,000 as mentioned in paper
% 3 represents the points indicies (x,y,img_slice_index)
% kernelsize is as mentioned in paper [9 9]
%
% Ouput
% patches is 2D matrix of size 81 by 12,000
% 81 (9x9) is size of every patch
% 12,000 is count of patches per images
function patches = octextractpatches(imgs, points, kernelsize)

kernelsizehalfw = fix(kernelsize(1)/2);
kernelsizehalfh = fix(kernelsize(2)/2);
patch_size = kernelsize(1)*kernelsize(2);
patches_count = length(points);

patches = zeros(patch_size, patches_count);
for i=1:patches_count
    % img = imgs(:,:,points(i,3));
    patch = imgs(points(i,1)-kernelsizehalfw:points(i,1)+kernelsizehalfw,...
        points(i,2)-kernelsizehalfh:points(i,2)+kernelsizehalfh,...
        points(i,3));
    patch = patch';
    patch = patch(:);
    % patch = (patch - mean(patch))./std(patch);
    % It is the same as the previous line
    patch = zscore(patch);
    patches(:,i) = patch;
end

end