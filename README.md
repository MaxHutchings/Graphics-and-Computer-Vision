# UP892525 - Graphics and Computer Vision Coursework

Task 1
---------

Run Program
-----------

Program has been tested and works on Firefox.

Firefox settings are the same that was used in Tutorial 7, which states:

If your program works but fails to load the textures, in Firefox URL type:
```
about:config
```
and navigate to:
```
security.fileuri.strict_origin_policy
```
and turn its value to false.
Reload the application.



Task 2
-------

Run Program
------------

This program was created in MATLAB R2019a.

Open test.m, and follow the instruction in that document to run the program.
The instructions state:

Running the program -
All images will be loaded when running, so choose the images that you want to
run and enter them into the my_application() function (which is highlighted).
This function needs two images, the closer image in the first parameter and the
further image in the second parameter.
As an example, img1 and img2 are already entered.

When running the fire engine test, enter:

```
my_application(fire1, fire2)
```

When running the oversized test, run:

```
my_application(oversized, oversized)
```

as there is only one image for the oversized car.

The output of the program will be two figures, each showing the main steps
of the image processing for each image. There will also be a list produced
in the command window which will display relevant information about the
images entered, e.g. car width, car length, car speed etc.
