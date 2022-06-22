%Assignment 1

% Apologies for the somewhat incomplete solutions with centering and removing images from the grid, I hope it is okay to
% keep working on this the next few days...

%a) at the start  randomly select 4 images and show them quickly (e.g. 0.2 seconds) in centre of screen (encoding).
clear all
close all 
clc

fileList=["cat1.jpg", "cat2.jpg", "cat3.jpg", "cat4.jpg", "cat5.jpg", "dog1.jpg", "dog2.jpg", "dog3.jpg", "dog4.jpg", "dog5.jpg"];
Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 800 600]);

% unsuccessful attempt at centering 
rectSizeX = 300;
rectSizeY = 200;
x = 400-rectSizeX/2;
y = 300-rectSizeY/2;

% selects a random index from the list of image files
randImageIndexes = randperm(10);

% create an empty array to record the images shown
recordedImages = [];
for image=1:4
    thisImage = fileList(randImageIndexes(image));
    %showThis = fileList(thisImage);
    im = imread(thisImage);
    tex = Screen('MakeTexture', win, im);
    Screen('DrawTexture', win, tex, [], [x y x+rectSizeX/2 y+rectSizeY/2]);
    %Screen('DrawTexture', win, tex, [], [800+Xshift 600+Yshift 800-Xshift 600-Yshift]);
    Screen(win, 'flip');
    pause(0.2);
    %b) Record which images were shown (encoded) and which were not.
    % this can be done using string concantenation:
    recordedImages = [recordedImages, thisImage];
end
%% c) Show the grid of all 9 images

fileList=["cat1.jpg", "cat2.jpg", "cat3.jpg", "cat4.jpg", "cat5.jpg", "dog1.jpg", "dog2.jpg", "dog3.jpg", "dog4.jpg"];

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 800 600]);

% constants
rectSize = 100; % distance between top-left and bottom-right corners of each rectangle
gridSize = 3; % number of rectangles per column
displaySize = rectSize*gridSize; % total pixels for display
    rectCount = 0;
    for x=1:rectSize:displaySize % goes through columns
        for y=1:rectSize:displaySize % goes through lines until display size is reached
        rectCount = rectCount + 1;
        myRects(rectCount,:) = [x y x+rectSize/2 y+rectSize/2]; % top left bottom right corners
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
