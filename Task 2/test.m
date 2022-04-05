%{
 Running the program -
 All images will be loaded when running, so choose the images that you want to
 run and enter them into the my_application() function (which is highlighted). 
 This function needs two images, the closer image in the first parameter and the
 further image in the second parameter. 
 As an example, img1 and img2 are already entered.
 
 When running the fire engine test, enter:

 my_application(fire1, fire2)

 
 When running the oversized test, run:
 
 my_application(oversized, oversized)
 
 as there is only one image for the oversized car.

 The output of the program will be two figures, each showing the main steps
 of the image processing for each image. There will also be a list produced
 in the command window which will display relevant information about the
 images entered, e.g. car width, car length, car speed etc.
%}

function test()
clear,
close all,

% read all images into variables
img1 = imread('001.jpg');
img2 = imread('002.jpg');
img3 = imread('003.jpg');
img4 = imread('004.jpg');
img5 = imread('005.jpg');
img6 = imread('006.jpg');
img7 = imread('007.jpg');
img8 = imread('008.jpg');
img9 = imread('009.jpg');
img10 = imread('010.jpg');
img11 = imread('011.jpg');

fire1 = imread('fire01.jpg');
fire2 = imread('fire02.jpg');

oversized = imread('oversized.jpg');

% ENTER THE IMAGES IN HERE
my_application(img1, img2)

end
