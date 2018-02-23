close all;

%% Setup
% read images and convert to floating point format
image1 = im2single(imread('data/bird.bmp'));
image2 = im2single(imread('data/plane.bmp'));

%% Filtering and Hybrid Image construction
cutoff_frequency = 4; %This is the standard deviation, in pixels, of the 
image1_gauss = imgaussfilt(image1, cutoff_frequency);
image2_gauss = imgaussfilt(image2, cutoff_frequency);

high_frequencies = image2 - image2_gauss;

hybrid_image = image1_gauss + high_frequencies;

%% Visualize and save outputs
figure(1); imshow(image1_gauss); title('Low Frequencies of Bird');
figure(2); imshow(high_frequencies + 0.5); title('High Frequencies of Plane');
vis = vis_hybrid_image(hybrid_image);
figure(3); imshow(vis); title('Hybrid Bird-Plane');
imwrite(image1_gauss, 'low_frequencies_3.jpg', 'quality', 95);
imwrite(high_frequencies + 0.5, 'high_frequencies_3.jpg', 'quality', 95);
imwrite(hybrid_image, 'hybrid_image_3.jpg', 'quality', 95);
imwrite(vis, 'hybrid_image_scales_3.jpg', 'quality', 95);