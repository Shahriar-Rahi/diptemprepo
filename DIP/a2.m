clear all;

%only for odd sized windows 
im = imread('mrbean.jpg');
gs = rgb2gray(im);

%odd sized masks 
mask_size = 5; % 3 5 7

[h, w] = size(gs);

to_pad = (mask_size - 1) / 2;
pgs = uint8(zeros(h + mask_size - 1, w + mask_size - 1));  %create a matrix, with 0 pads, based on the mask size, 1 if mask size is 3x3, 2 if 5x5, 3 if 7x7 blablalabl
pgs(to_pad + 1 : h + to_pad, to_pad + 1 : w + to_pad) = gs; %set the non padded area to the image 
%pad borders if necessary 

ngs = imnoise(gs, 'salt & pepper');
subplot(1, 2, 1)
imshow(ngs);

pgs(to_pad + 1 : h + to_pad, to_pad + 1 : w + to_pad) = ngs;

asf = ngs;
for i = to_pad + 1 : h +  to_pad - 1
    for j = to_pad + 1 : w + to_pad - 1
        s = sum(sum(pgs(i - to_pad : i + to_pad, j - to_pad : j +to_pad)));  %sum of all the elements in the window of the current pixel
        %disp(i + ", " + j);
        av = s / (mask_size * mask_size);
        asf(i - to_pad, j - to_pad) = av; % set the average value of the window just obtained 
    end
end

disp(61);

%PSNR
sss = double(0.0);
for i = 1 : h
    for j = 1 : w
        %replace asf with the current result after using filter
        sss = double(double(sss) + ((double(gs(i, j)) - double(asf(i, j))) ^ 2.0));
        %disp(sss);
    end
end

sss = sss / double(h * w);

psnravg = 10 * log10(double(255 ^ 2) / sss);
disp(psnravg);

subplot(1, 2, 2)
imshow(asf);