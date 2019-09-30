RGB = imread('mrbean.jpg');

figure;

imshow(RGB);

gray = rgb2gray(RGB);

figure;

imshow(gray);

binary_image=convert2binary(gray);

figure;

imshow(binary_image);

function [binary] = convert2binary(gray) 

	[x, y]=size(gray);
 
	gray=double(gray); 

	sum=0; 
	for i=1:x 
		for j=1:y 
            sum=sum+gray(i, j); 
        end
	end
 
	threshold=sum/(x*y); 
	

	binary=zeros(x, y); 
 

	for i=1:x 
        for j=1:y 
            if gray(i, j) >= threshold 
                binary(i, j) = 1; 
            else
                binary(i, j)=0; 
            end
        end
    end
end   
