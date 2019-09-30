RGB = imread('mrbean.jpg');

gray = rgb2gray(RGB);


[x, y] = size(gray); 


frequency = 1 : 256; 

count = 0; 

for i = 1 : 256 
	for j = 1 : x 
		for k = 1 : y 

			if gray(j, k) == i-1 
					count = count + 1; 
			end
		end
    end
    
	frequency(i) = count; 

	count = 0; 

end

cfreq = 1 : 256;

cnt = 0;

tp = x * y;

eqhist = 1 : 256;

for p = 1 : 256
    cnt = frequency(p) + cnt;
    cfreq(p) = cnt;
    eqhist(p) = ( cfreq(p) / tp ) * 255;
end

figure;

n = 0 : 255; 

stem(n, frequency); 

grid on; 
ylabel('Number of pixels with such intensity levels -->'); 
xlabel('Intensity Levels -->'); 
title('HISTOGRAM OF THE IMAGE');


figure;

u = 0 : 255;

stem(u, eqhist);

grid on; 
ylabel('Number of pixels with such intensity levels -->'); 
xlabel('Intensity Levels -->'); 
title('EQUALIZED HISTOGRAM OF THE IMAGE');