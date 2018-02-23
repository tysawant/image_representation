img = im2single(imread('data\images\126007.jpg'));
%imshow(img)
sd = 7;
[mag, theta] = gradientMagnitude(img, sd);
figure();
imagesc(mag)
figure();
imagesc(theta)
nms = edge(img(:, :, 1),'Canny');
figure();
subplot(1, 3, 1);
imshow(nms)
nms = edge(img(:, :, 2),'Canny');
subplot(1, 3, 2);
imshow(nms)
nms = edge(img(:, :, 3),'Canny');
subplot(1, 3, 3);
imshow(nms)
bmap = edgeGradient(rgb2gray(img));
figure();
imshow(bmap)

function [mag, theta] = gradientMagnitude(im, sigma)
g = fspecial('Gaussian', sigma);
%smooth_im = imfilter(im,g);
R = im(:, :, 1);
smooth_imR = imfilter(R,g);
G = im(:, :, 2);
smooth_imG = imfilter(G,g);
B = im(:, :, 3);
smooth_imB = imfilter(B,g);

[m,n] = size(R);

xg_R = imfilter(smooth_imR, [1 0 -1]);
yg_R = imfilter(smooth_imR, [1 0 -1]');
g_R = sqrt((abs(xg_R)).^2 + (abs(yg_R)).^2);

xg_G = imfilter(smooth_imG, [1 0 -1]);
yg_G = imfilter(smooth_imG, [1 0 -1]');
g_G = sqrt((abs(xg_G)).^2 + (abs(yg_G)).^2);

xg_B = imfilter(smooth_imB, [1 0 -1]);
yg_B = imfilter(smooth_imB, [1 0 -1]');
g_B = sqrt((abs(xg_B)).^2 + (abs(yg_B)).^2);

mag = sqrt((abs(xg_R)).^2 + (abs(xg_G)).^2 + (abs(xg_B)).^2 + (abs(yg_R)).^2 + (abs(yg_G)).^2 + (abs(yg_B)).^2);
%mag = sqrt((abs(xgNorm)).^2 + (abs(ygNorm)).^2);

for 
    
end
theta = atan2(yg_R,xg_R);
end

function bmap = edgeGradient(im)
bmap = edge(im,'Canny');
end