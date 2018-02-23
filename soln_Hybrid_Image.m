close all;

%% Setup
% read images and convert to floating point format
image1 = im2single(imread('prob_hybrid/data/Afghan_girl_before.jpg'));
image2 = im2single(imread('prob_hybrid/data/Afghan_girl_after.jpg'));

%% Filtering and Hybrid Image construction
cutoff_frequency = 5; %This is the standard deviation, in pixels, of the 
image1_gauss = imgaussfilt(image1, cutoff_frequency);
image2_gauss = imgaussfilt(image2, cutoff_frequency);

high_frequencies = image2 - image2_gauss;

hybrid_image = image1_gauss + high_frequencies;

%% Log Magnitudes
ori1 = log(abs(fftshift(fft2(image1))));
ori2 = log(abs(fftshift(fft2(image2))));
low = log(abs(fftshift(fft2(image1_gauss))));
high = log(abs(fftshift(fft2(high_frequencies))));
hybrid = log(abs(fftshift(fft2(hybrid_image))));

%% Visualize and save outputs
figure(1); imshow(image1_gauss); title('Low Frequencies of Before Photo');
figure(2); imshow(high_frequencies + 0.5); title('High Frequencies of After Photo');
vis = vis_hybrid_image(hybrid_image);
figure(3); imshow(vis); title('Hybrid Before-After');
figure(4); subplot(3,2,1); imagesc(ori1); title('Log magninitude of FFT-Before');
subplot(3,2,2); imagesc(ori2); title('Log magninitude of FFT-After');
subplot(3,2,3); imagesc(low); title('Log magninitude of FFT-Low');
subplot(3,2,4); imagesc(high); title('Log magninitude of FFT-High');
subplot(3,2,5); imagesc(hybrid); title('Log magninitude of FFT-Hybrid');
imwrite(image1_gauss, 'low_frequencies_2.jpg', 'quality', 95);
imwrite(high_frequencies + 0.5, 'high_frequencies_2.jpg', 'quality', 95);
imwrite(hybrid_image, 'hybrid_image_2.jpg', 'quality', 95);
imwrite(vis, 'hybrid_image_scales_2.jpg', 'quality', 95);