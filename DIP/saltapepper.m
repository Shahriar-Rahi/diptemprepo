%loads the image and makes double precision representation for computations

A = imread('mrbean.jpg');

B=rgb2gray(A);

[rows, columns] = size(B); %computes the dimensions of the image


%displays the original image with appropriate title

figure(1)

imshow(B);

%colormap(gray(256));

axis('image');

title('Original image')


%makes a copy of the original image to be salted/peppered with noise

noisy_image = B;

noise_percent = 20;


for i = 1:rows %for loops iterate through every pixel

   for j = 1:columns
       noise_check = randi(noise_percent); %creates a random number between 1 and noise_percent
       if noise_check == noise_percent    %if the random number = noise_percent (1/noise_percent chance of any given pixel being noisy)
           noise_value = randi(256);    %creates a random noise value to replace the pixel
           noisy_image(i,j) = noise_value; %replaces the original pixel value with the random noise
       end
   end
end


%displays the noisy image with appropriate title

figure(2)

imshow(noisy_image);

%colormap(gray(256));

axis('image');

title('Salt and pepper noise image')