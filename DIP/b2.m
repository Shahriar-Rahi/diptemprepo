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

%geomatric mean filter, set current pixel's intensity value to the
%geomatric sum, as in pix = (a * b * c * d * e * f * g * h * i) ^
%mask_size*mask_size (3x3 or 5x5 or anything) 

gmf = gs;
for i = to_pad + 1 : h +  to_pad - 1
    for j = to_pad + 1 : w + to_pad - 1
        s = prod(prod(pgs(i - to_pad : i + to_pad, j - to_pad : j + to_pad)));
        %disp(i + ", " + j);
        el = nthroot(s, mask_size * mask_size);
        gmf(i - to_pad, j - to_pad) = el;
    end
end

subplot(1, 2, 1)
imshow(gmf);

%harmonic mean filter  same as before, jsut the harmonic mean
% 
hmf = double(ngs);
avsum = double(0.0);
for i = to_pad + 1 : h +  to_pad - 1
    for j = to_pad + 1 : w + to_pad - 1
        for k = i - to_pad : i + to_pad
            for l = j - to_pad : j + to_pad
                avsum = avsum + (double(pgs(k, l) + 1))^-1;
                %X = sprintf("k = %d, l = %d, pgs(k, l) = %d", k, l, pgs(k, l));
                %disp(X);
            end
        end
        %disp(avsum);
        rep = double((double(mask_size * mask_size)) / avsum);
        hmf(i - to_pad, j - to_pad) = rep;
        avsum = 0;
    end
end

hmf = uint8(hmf);
subplot(1, 2, 2)
imshow(hmf);

ssshm = double(0.0);
for i = 1 : h
    for j = 1 : w
        %replace asf with the current result after using filter
        ssshm = double(double(ssshm) + ((double(gs(i, j)) - double(hmf(i, j))) ^ 2.0));
        %disp(sss);
    end
end

ssshm = ssshm / double(h * w);

psnrhm = 10 * log10(double(255 ^ 2) / ssshm);
disp(psnrhm);


sssgm = double(0.0);
for i = 1 : h
    for j = 1 : w
        %replace asf with the current result after using filter
        sssgm = double(double(sssgm) + ((double(gs(i, j)) - double(gmf(i, j))) ^ 2.0));
        %disp(sss);
    end
end

sssgm = sssgm / double(h * w);

psnrgm = 10 * log10(double(255 ^ 2) / sssgm);
disp(psnrgm);