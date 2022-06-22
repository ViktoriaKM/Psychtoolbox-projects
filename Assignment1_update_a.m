%Assignment 1

% Apologies for the somewhat incomplete solutions with centering and removing images from the grid, I hope it is okay to
% keep working on this the next few days...

%a) at the start  randomly select 4 images and show them quickly (e.g. 0.2 seconds) in centre of screen (encoding).
clear all
close all 
clc

fileList=["cat1.jpg", "cat2.jpg", "cat3.jpg", "cat4.jpg", "cat5.jpg", "dog1.jpg", "dog2.jpg", "dog3.jpg", "dog4.jpg", "dog5.jpg"];
Screen('Preference', 'SkipSyncTests', 1);

% define the display size and open a window
width = 1200;
height = 800;
win = Screen('OpenWindow',0, [127 127 127],[0 0 width height]);

% all the animal pictures are 600 pixels wide and 400 pixels high
rectsizeX = 600;
rectsizeY = 400;
left = (width/2)-(rectsizeX/2);
top = (height/2) - (rectsizeY/2);
right = (width/2) + (rectsizeX/2);
bottom = (height/2) + (rectsizeY/2);

% selects a random index from the list of image files
randImageIndexes = randperm(10);

% create an empty array to record the images shown
recordedImages = [];
for image=1:4
    thisImage = fileList(randImageIndexes(image));
    im = imread(thisImage);
    tex = Screen('MakeTexture', win, im);
    Screen('DrawTexture', win, tex, [], [left top right bottom]);
    Screen(win, 'flip');
    pause(0.2);
    %b) Record which images were shown (encoded) and which were not.
    % this can be done using string concantenation:
    recordedImages = [recordedImages, thisImage];
end
%% c) Show the grid of all 9 images

fileList=["cat1.jpg", "cat2.jpg", "cat3.jpg", "cat4.jpg", "cat5.jpg", "dog1.jpg", "dog2.jpg", "dog3.jpg", "dog4.jpg"];

Screen('Preference', 'SkipSyncTests', 1);
[win, windowSize] = Screen('OpenWindow',0, [127 127 127],[0 0 800 600]);
% windwoSize returns a pointer to the size of the window; 800*600 pixels

% constants
rectSize = 200; % distance between top-left and bottom-right corners of each rectangle
gridSize = 3; % number of rectangles per column
displaySize = rectSize*gridSize; % total pixels for display
squareSize = rectSize/2;

Xshift = windowSize(3)/2 - (displaySize-rectSize/2)/2;
Yshift = windowSize(4)/2 - (displaySize-rectSize/2)/2;
%myRects = zeroes(3,3); % defines the grid
    rectCount = 0;
    for x=1:rectSize:displaySize % goes through columns
        for y=1:rectSize:displaySize % goes through lines until display size is reached
        rectCount = rectCount + 1;
        myRects(rectCount,:) = [x y x+squareSize y+squareSize]; % top left bottom right corners
        myRects(rectCount, [1 3]) = myRects(rectCount,  [1 3]) + Xshift; % apply Xshift to first and third elements
        myRects(rectCount, [2 4]) = myRects(rectCount, [2 4]) + Yshift;
        end
    end

inClick = 0; % counts number of clicks that are within an image
% when the counter hits 9, the experiment should stop, since all images
% have been clicked.
numClicks = 0; % counter for how many images have been clicked
while inClick < 10  
    [Xmouse Ymouse buttons] = GetMouse;
    totalNumberRect = rectCount;
    for k=1:9 % loops through myRects
        rect =  myRects(k,:);
        
        im = imread(fileList(k));
        tex = Screen('MakeTexture', win, im);
        Screen('DrawTexture', win, tex, [], rect);
       
        withinMyRects = Xmouse > rect(1) && Xmouse < rect(3) && Ymouse > rect(2) && Ymouse < rect(4);
        
        %d) Stop the experiment when the shown images are clicked (or if all the targets are clicked)
        if withinMyRects && ...
            buttons(1)
            % if the click is within a rectangle, the inClick variable
            % should be incremented:
            inClick = inClick + 1;
            %f) Images disappear if clicked
            % fill rect with background color
             Screen(win, 'FillRect', [127 127 127], rect);
             
        end
        if buttons(1) % for any click, the numClick variable should be updated:
            %e) Calculate accuracy. (Hits / NumClicks)
             numClicks = numClicks + 1;
        end
    end
    Screen(win, 'Flip');
end
sca

accuracy = num2str(inClick/numClicks);
disp('Your accuracy is ' + accuracy);
