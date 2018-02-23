close all;

%% Initialization
N = 5;
I = im2single(imread('prob_pyramids\white-tiger.jpg'));
G = cell(1,N);
L = cell(1,N);
T = cell(1,N);
S = cell(1,N);
F_G = cell(1,N);
F_L = cell(1,N);

%% Creating Gaussian and Lapacian Pyramids
for k = 1:N
[G,L] = pyramidsGL(I,k);
T{k} = [G{k}];
S{k} = [L{k}];
I = imresize(T{k},0.5);
end

%% Taking FFTs of the Gaussian and Laplacian Pyramids

for p = 1:N
F_G{p} = abs(fftshift(fft2(T{p})));
F_L{p} = abs(fftshift(fft2(S{p})));
end

%% Displaying Gaussian and Laplacian Pyramids
figure();
for g = 1:2*N
  
    if g<=N
        subplot(2,N,g)
        imshow(T{g})
    else
        subplot(2,N,g)
        imshow(S{g-N})
    end
end

%% Displaying FFTS of Gaussian and Laplacian Pyramids
figure();
for f = 1:2*N
  
    if f<=N
        subplot(2,N,f)
        image(F_G{f})
    else
        subplot(2,N,f)
        image(F_L{f-N})
    end
end

%% Function Definition

function [G, L] = pyramidsGL(IM,k)
 G{1,k} = imgaussfilt(IM);
 L{1,k} = mat2gray(IM - G{1,k});
end

