function my_application(image1, image2)
% call the functions to process the images
[carWidth, carLength, dist1, boundingBox] = sizeDetection(image1);
% only need the distance to the back of the car from the second image
[~, ~, dist2, ~] = sizeDetection(image2);

carColour = colourDetection(boundingBox, image1);

% calculate car speed with the two distances
carSpeed = speedDetection(dist1, dist2);

% work out if the car is speeding
if carSpeed >= 30
    isSpeeding = 'Y';
else
    isSpeeding = 'N';
end

% work out if vehicle is fire engine
if contains(carColour, 'Blue')
    isFE = 'N';
else
    isFE = 'Y';
end

% work out if the car is oversized
if carWidth >= 2.5
    isOversized = 'Y';
else
    isOversized = 'N';
end

% display outputs
disp(['Car width: ', num2str(carWidth), ' meters'])
disp(['Car length: ', num2str(carLength), ' meters'])
disp(['Car width/length ratio: ', num2str(carWidth), ' : ', num2str(carLength)])
disp(['Car speed: ', num2str(carSpeed), ' mph'])
disp(['Car colour: ', carColour])
disp(['Car is speeding (Y/N): ', isSpeeding])
disp(['Car is oversised (Y/N): ', isOversized])
disp(['Car is fire engine (Y/N): ', isFE])
end

function [carWidth, carLength, backDistance, boundingBox] = sizeDetection(image)
% apply gaussian filter
gaus = fspecial('gaussian', [10,10], 3);
g = imfilter(image, gaus);

% colour segmentation using K-Means clustering
lab = rgb2lab(g);   % covert to L*a*b colour space
ab = lab(:,:,2:3);
ab = im2single(ab);
pixel_labels = imsegkmeans(ab, 2, 'NumAttempts', 2);    % splitting image into two objects
mask = pixel_labels == 2;                               % seperate the 2nd object (car) into a mask
cluster = g .* uint8(mask);                             % apply the mask to the image

% grayscale image
gr = rgb2gray(cluster);
% binarize image
bi = imbinarize(gr, 0.002);

% canny edges
BW1 = edge(bi, 'canny');

% find the leftmost, rightmost, upper and lower pixels of the image
[rows, columns] = find(bi);
leftMost = min(columns);
rightMost = max(columns);
highest = min(rows);
lowest = max(rows);

% width and height of bounding box
width = rightMost - leftMost;
height = lowest - highest;

% rectangle array for the bounding box
boundingBox = [leftMost, highest, width, height];

% find center point of the bounding box
centerX = leftMost + (width/2);
centerY = highest + (height/2);

% work out the distances (front, middle and back of the car)
frontDistance = calcDist(highest);
middleDistance = calcDist(centerY);
backDistance = calcDist(lowest);

% work out the cars length
carLength = frontDistance - backDistance;

% work out the cars width
widthAngle = (width * 0.042) / 2;
carHalfWidth = middleDistance * tand(widthAngle);
carWidth = carHalfWidth * 2;

% creating the figure to show all of the stages of an image
figure, hold on
subplot(1,5,1)
imshow(g)
title('Smoothed Gaussian Filter')

subplot(1,5,2)
imshow(cluster)
title('Object in cluster')

subplot(1,5,3)
imshow(BW1)
title('Edges')

subplot(1,5,4)
imshow(image)
title('Bounding Box')
rectangle('Position', boundingBox, 'EdgeColor', 'r', 'LineWidth', 2)

subplot(1,5,5)
imshow(image)
title('Center')
hold on
plot([centerX, centerX], [centerY - 6, centerY + 6], 'LineWidth', 2, 'Color', 'r');
plot([centerX - 6, centerX + 6], [centerY, centerY], 'LineWidth', 2, 'Color', 'r');
hold off

hold off
end

function colour = colourDetection(boundingBox, image)
% select just the bounding box as an image
croppedImage = imcrop(image, boundingBox);

red = croppedImage(:,:,1);
blue = croppedImage(:,:,3);

% use the histograms to find the maximum count of a colour
[blueCount, ~] = imhist(blue);
blueCount = max(blueCount);
[redCount, ~] = imhist(red);
redCount = max(redCount);

% more dominant colour is the colour of the car
if blueCount > redCount
    colour = 'Red';
else
    colour = 'Blue';
end
end

% calculates speed in mph given two distances
function speed = speedDetection(dist1, dist2)
%dist in meters and time in seconds
distDiff = dist2 - dist1;
%speed in m/s
speedMS = distDiff / 0.1;
%convert to mph
speed = convvel(speedMS, 'm/s', 'mph');
end

% work out the distance to the camera 
function dist = calcDist(numOfPixels)
angle = 60 + ((320 - numOfPixels) * 0.042);
% cos(x) = adj / hyp
dist = 7 / cosd(angle);
end