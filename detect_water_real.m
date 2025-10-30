%% ============================
%  WATER BODY DETECTION using NDWI
%  Real Landsat Data Version
%  Date: October 2025
%% ============================

clear all; close all; clc;
warning('off','all');

% Project directories
projectRoot = pwd;
dataDir = fullfile(projectRoot, 'data');
outputDir = fullfile(projectRoot, 'results');
if ~exist(outputDir, 'dir'), mkdir(outputDir); end

fprintf('\n=== WATER BODY DETECTION PROJECT (Real Landsat Data) ===\n');
fprintf('Bands Used: Landsat 8/9 B3 (Green), B5 (NIR)\n');

%% 1. READ THE REAL GEOTIFFS
% ---- Update filenames below as per your download ----
greenBandFile = 'LC08_L1GT_148046_20250816_20250821_02_T2_B3.TIF';
nirBandFile   = 'LC08_L1GT_148046_20250816_20250821_02_T2_B5.TIF';


% Read bands with spatial referencing info
[greenBand, Rg] = readgeoraster(greenBandFile);
[nirBand, Rn]   = readgeoraster(nirBandFile);

fprintf('✓ Successfully loaded Landsat Green and NIR bands\n');

% Convert to double for processing
greenBand = double(greenBand);
nirBand = double(nirBand);

% Remove invalid pixels (zeros, negatives)
greenBand(greenBand <= 0) = NaN;
nirBand(nirBand <= 0) = NaN;

fprintf('✓ Data preprocessing completed\n');
fprintf('- Green band range: %.1f to %.1f\n', min(greenBand(:)), max(greenBand(:)));
fprintf('- NIR band range: %.1f to %.1f\n', min(nirBand(:)), max(nirBand(:)));

%% 2. GAUSSIAN FILTERING (NOISE REDUCTION)
fprintf('\nApplying Gaussian Filtering for Smoothing...\n');
sigma = 1.0; kernelSize = 5;
gaussianKernel = fspecial('gaussian', [kernelSize kernelSize], sigma);
greenFiltered = imfilter(greenBand, gaussianKernel, 'replicate');
nirFiltered = imfilter(nirBand, gaussianKernel, 'replicate');

%% 3. CONTRAST STRETCHING
fprintf('Applying Contrast Stretching...\n');
greenStretched = contrastStretch(greenFiltered, 2, 98);
nirStretched   = contrastStretch(nirFiltered, 2, 98);

%% 4. COMPUTE NDWI AND SEGMENT WATER
fprintf('Calculating NDWI and segmenting water bodies...\n');
ndwi = (greenStretched - nirStretched) ./ (greenStretched + nirStretched);
ndwi(isinf(ndwi) | isnan(ndwi)) = 0;
finalWaterMask = ndwi > 0;

%% 5. MORPHOLOGICAL CLEANUP
fprintf('Refining water mask...\n');
se = strel('disk', 2);
waterMaskCleaned = imopen(finalWaterMask, se);
waterMaskFilled = imclose(waterMaskCleaned, strel('disk',3));

%% 6. VISUALIZE RESULTS
fprintf('Generating results and saving files...\n');
figure('Position', [0 0 1400 600]);
subplot(2,3,1); imagesc(greenBand); axis image off; title('Green Band'); colorbar;
subplot(2,3,2); imagesc(nirBand); axis image off; title('NIR Band'); colorbar;
subplot(2,3,3); imagesc(ndwi, [-1 1]); axis image off; title('NDWI'); colorbar;
subplot(2,3,4); imshow(finalWaterMask); title('Raw Water Mask');
subplot(2,3,5); imshow(waterMaskFilled); title('Refined Water Mask');
subplot(2,3,6); 
rgbOverlay = repmat(mat2gray(greenBand), [1,1,3]);
rgbOverlay(:,:,1) = rgbOverlay(:,:,1) + double(waterMaskFilled);
imshow(rgbOverlay); title('Water Highlighted');

sgtitle('Water Body Detection in Mumbai AOI - Landsat Imagery');

imwrite(mat2gray(ndwi), jet(256), fullfile(outputDir, 'ndwi_map_real.png'));
imwrite(waterMaskFilled, fullfile(outputDir, 'water_mask_real.png'));
imwrite(rgbOverlay, fullfile(outputDir, 'water_overlay_real.png'));

fprintf('Results saved to %s\n', outputDir);

%% SUPPORTING FUNCTION
function stretched = contrastStretch(image, lowP, highP)
    validPix = image(~isnan(image));
    low = prctile(validPix, lowP); high = prctile(validPix, highP);
    stretched = (image - low) / (high - low);
    stretched(stretched < 0) = 0; stretched(stretched > 1) = 1;
    stretched(isnan(image)) = NaN;
end
