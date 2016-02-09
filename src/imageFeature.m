function [ feature] = imageFeature( images, method )
% This function extrac feature of image and then output the feature
    RAW_IMAGE = 1;
    [x, y, d, k] = size(images); 
    if method == RAW_IMAGE; 
        feature = double(reshape(images, x * y * d, k));
    end

end

