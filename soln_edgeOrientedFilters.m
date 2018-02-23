%% Initialization
img1 = im2single(imread('prob_edge\data\images\86000.jpg'));
imshow(img1);
sd = 7;

%% Obtaining magnitude and Orientation
[mag, theta] = orientedFilterMagnitude(img1);
figure();
imshow(mag)
figure();
imshow(mat2gray(theta))

%% Non maxima Suppression

nms = edgeOrientedFilters(mag);
figure();
imshow(nms);

%% Function Definition
function [mag, theta] = orientedFilterMagnitude(im)
g = fspecial('Gaussian');
g_der_0 = imfilter(g,[1 0 -1; 1 0 -1; 1 0 -1]);
g_der_90 = imfilter(g,[1 1 1; 0 0 0; -1 -1 -1]);
g_der_180 = imfilter(g,[-1 0 1; -1 0 1; -1 0 1]);
g_der_270 = imfilter(g,[-1 -1 -1; 0 0 0; 1 1 1]);

R = im(:, :, 1);
[m,n] = size(R);
theta = size(R);
G = im(:, :, 2);
B = im(:, :, 3);

R_0 = imfilter(R, g_der_0);
R_90 = imfilter(R, g_der_90);
R_180 = imfilter(R, g_der_180);
R_270 = imfilter(R, g_der_270);
R_xg = imfilter(R, [1 0 -1]);
R_yg = imfilter(R, [1 0 -1]');

G_0 = imfilter(G, g_der_0);
G_90 = imfilter(G, g_der_90);
G_180 = imfilter(G, g_der_180);
G_270 = imfilter(G, g_der_270);
G_xg = imfilter(G, [1 0 -1]);
G_yg = imfilter(G, [1 0 -1]');

B_0 = imfilter(B, g_der_0);
B_90 = imfilter(B, g_der_90);
B_180 = imfilter(B, g_der_180);
B_270 = imfilter(B, g_der_270);
B_xg = imfilter(B, [1 0 -1]);
B_yg = imfilter(B, [1 0 -1]');

mag_R = sqrt((abs(R_0)).^2 + abs(R_90).^2 + abs(R_180).^2 + abs(R_270).^2);
mag_G = sqrt((abs(G_0)).^2 + abs(G_90).^2 + abs(G_180).^2 + abs(G_270).^2);
mag_B = sqrt((abs(B_0)).^2 + abs(B_90).^2 + abs(B_180).^2 + abs(B_270).^2);
mag = sqrt((abs(mag_R)).^2 + (abs(mag_G)).^2 + (abs(mag_B)).^2);

for a = 1:m
    for b = 1:n
        pixR = [R_0(a,b) R_90(a,b) R_180(a,b) R_270(a,b)];
        if (max(pixR) == pixR(1))
            theta_R(a,b) = R_0(a,b);
        elseif (max(pixR) == pixR(2))
            theta_R(a,b) = R_90(a,b);
        elseif (max(pixR) == pixR(3))
            theta_R(a,b) = R_180(a,b);
        elseif (max(pixR) == pixR(4))
            theta_R(a,b) = R_270(a,b);
        end
    end
end

for a = 1:m
    for b = 1:n
        pixG = [G_0(a,b) G_90(a,b) G_180(a,b) G_270(a,b)];
        if (max(pixG) == pixG(1))
             theta_G(a,b) = G_270(a,b);
        elseif (max(pixG) == pixG(2))
            theta_G(a,b) = G_270(a,b);
        elseif (max(pixG) == pixG(3))
            theta_G(a,b) = G_270(a,b);
        elseif (max(pixG) == pixG(4))
           theta_G(a,b) = G_270(a,b);
        end
    end
end


for a = 1:m
    for b = 1:n
        pixB = [B_0(a,b) B_90(a,b) B_180(a,b) B_270(a,b)];
        if (max(pixB) == pixB(1))
             theta_B(a,b) = B_270(a,b);
        elseif (max(pixB) == pixB(2))
            theta_B(a,b) = B_270(a,b);
        elseif (max(pixB) == pixB(3))
            theta_B(a,b) = B_270(a,b);
        elseif (max(pixB) == pixB(4))
            theta_B(a,b) = B_270(a,b);
        end
    end
end

for a = 1:m
    for b = 1:n
        pix = [theta_R(a,b) theta_G(a,b) theta_B(a,b)];
        if (max(pix) == pix(1))
             theta(a,b) = atan2(R_yg(a,b), R_xg(a,b));
            %theta(a,b) = theta_R(a,b);
        elseif (max(pix) == pix(2))
             theta(a,b) = atan2(G_yg(a,b), G_xg(a,b));
             %theta(a,b) = theta_G(a,b);
        elseif (max(pix) == pix(3))
             theta(a,b) = atan2(B_yg(a,b), B_xg(a,b)); 
             %theta(a,b) = theta_B(a,b);
        end
    end
end
end

function bmap = edgeOrientedFilters(im)
bmap = edge(im, 'Canny');
end