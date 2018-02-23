close all;
N = 5;
I = im2single(imread('white-tiger.jpg'));
G = cell(1,N);
L = cell(1,N);
T = cell(1,N);
S = cell(1,N);

for k = 1:N
[G,L] = pyramidsGL(I,k);
%A = imresize(G{k},k,'bilinear');
T{k} = [G{k}];
%B = imresize(L{k},2*k);
S{k} = [L{k}];
%I = imresize(T{k}, 0.5, 'bilinear');
I = impyramid(T{k},'reduce');
%figure();
%A = imresize(G{k},k);
%imshow(A);
%figure();
%imshow(B);
end

figure();
subplot(2,5,1)
imshow(T{1})
subplot(2,5,2)
imshow(T{2})
subplot(2,5,3)
imshow(T{3})
subplot(2,5,4)
imshow(T{4})
subplot(2,5,5)
imshow(T{5})
subplot(2,5,6)
imshow(S{1})
subplot(2,5,7)
imshow(S{2})
subplot(2,5,8)
imshow(S{3})
subplot(2,5,9)
imshow(S{4})
subplot(2,5,10)
imshow(S{5})

function [G, L] = pyramidsGL(IM,k)
 %g = fspecial('gaussian');
 %l = fspecial('log');
 G{1,k} = imgaussfilt(IM);
 L{1,k} = mat2gray(IM - G{1,k});
end

