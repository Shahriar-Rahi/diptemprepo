clear all;

im = imread('mrbean.jpg'); %read image 512 x 512

gs = rgb2gray(im);

gsd = double(gs) /255;

factor = 3; 

[h, w] = size(gs);

%power law c = factorr * r^gamma
plaw = gsd;
for i = 1 : h
    for j = 1 : w
        plaw(i, j) = factor * gsd(i, j)^5;
    end
end

%multiply back to get the values in the range of 0 - 255
plaw = plaw * 255;
subplot(1, 2, 1)
imshow(plaw);


ilgt = gsd;

for i = 1 : h
    for j = 1 : w
        ilgt(i, j) = factor ^ (gsd(i, j) / 0.1) - 1;
        %ligt = (exp(gsd(i, j)) .^ (1/factor)) - 1;
    end
end
%ilgt = ilgt * 255;
ilgt = uint8(ilgt);
subplot(1, 2, 2)
imshow(ilgt);
        