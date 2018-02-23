%% Initialization
img = im2single(imread('prob_edge\data\images\102061.jpg'));
imshow(img);
sd = 7;
%theta = size(img(:,:,1));

%% Obtaining magnitude and Orientation
figure();
imshow(mag)
figure();
imagesc(theta)

%% Non maxima Suppression
[mag, theta] = gradientMagnitude(img, sd);
nms = edgeGradient(mag);
figure();
imshow(nms);

%% Function Definition
function [mag, theta] = gradientMagnitude(im, sigma)
g = fspecial('Gaussian', sigma);
%smooth_im = imfilter(im,g);
R = im(:, :, 1);
[m,n] = size(R);
theta = size(R);
smooth_imR = imfilter(R,g);
G = im(:, :, 2);
smooth_imG = imfilter(G,g);
B = im(:, :, 3);
smooth_imB = imfilter(B,g);

xg_R = imfilter(smooth_imR, [1 0 -1]);
yg_R = imfilter(smooth_imR, [1 0 -1]');
g_R = sqrt((abs(xg_R)).^2 + (abs(yg_R)).^2);

xg_G = imfilter(smooth_imG, [1 0 -1]);
yg_G = imfilter(smooth_imG, [1 0 -1]');
g_G = sqrt((abs(xg_G)).^2 + (abs(yg_G)).^2);

xg_B = imfilter(smooth_imB, [1 0 -1]);
yg_B = imfilter(smooth_imB, [1 0 -1]');
g_B = sqrt((abs(xg_B)).^2 + (abs(yg_B)).^2);

xgNorm = sqrt((abs(xg_R)).^2 + (abs(xg_G)).^2 + (abs(xg_B)).^2);
ygNorm = sqrt((abs(yg_R)).^2 + (abs(yg_G)).^2 + (abs(yg_B)).^2);
mag = sqrt((abs(xgNorm)).^2 + (abs(ygNorm)).^2);

for a = 1:m
    for b = 1:n
        M = [g_R(a,b) g_G(a,b) g_B(a,b)];
        if (max(M) == M(1))
            theta(a,b) = atan2(abs(yg_R(a,b)),abs(xg_R(a,b)));
        elseif (max(M) == M(2))
            theta(a,b) = atan2(abs(yg_G(a,b)),abs(xg_G(a,b)));
        elseif (max(M) == M(3))
            theta(a,b) = atan2(abs(yg_B(a,b)),abs(xg_B(a,b)));
        end
    end
end
end

function bmap = edgeGradient(im)
bmap = edge(im,'Canny');
end