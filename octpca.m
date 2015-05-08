%% OCT PCA
% Input
% Normalized patches are expected to be a 2D Matrix where
% Rows equal to 81 (9x9) which is the size of each interest point patch
% Columns equal to 12000 which are the number of interest points in every
% OCT volume
% Patches are expected to be normailized around zero mean and unit variance
% principal_component_counts is expected to be 9 as mentioned in the paper
%
% Output
% V is matrix of size 12000 by 9 where 9 is principal_component_counts
% It represents the first 9 principal component vectors
function [V,D] = octpca(patches, principal_component_counts)
    CovMat=cov(patches);
    [V,D]=eigs(CovMat,principal_component_counts);
end