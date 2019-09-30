RGB = imread('mrbean.jpg');

imshow(RGB);

gray = rgb2gray(RGB);

figure;

imshow(gray);

neg = 255 - gray;

figure;

imshow(neg);