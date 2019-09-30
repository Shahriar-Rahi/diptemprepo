clear all;

im = imread('mrbean.jpg'); %read image 512 x 512

gs = rgb2gray(im);

figure
imshow(gs);

[h, w] = size(gs);
%gray level slicing 
levels = [40, 80];
gsl = gs;
for i = 1 : h
    for j = 1 : w
        %if the pixel value is in  the range of [40, 80] or any range
        %specified, assign a higher intensity value for that pixel
        if gs(i, j) > levels(1) && gs(i, j) < levels(2)
            gsl(i, j) = gs(i, j) + 20;
        end
    end
end

figure
imshow(gsl);

%or like 
%gray level slicing 
% levels = [30, 40];
% gsl = uint8(zeros(h, w));
% for i = 1 : h
%     for j = 1 : w
%         %if the pixel value is in  the range of [30, 40] or any range
%         %specified, assign a higher intensity value for that pixel
%         if gs(i, j) > levels(1) && gs(i, j) < levels(2)
%             gsl(i, j) = 60;
%         %otherwise a lower one 
%         else
%             gsl(i, j) = 20;
%         end
%     end
% end