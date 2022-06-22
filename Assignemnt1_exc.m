clear all
close all 
clc

fileList=["cat1.jpg", "cat2.jpg", "cat3.jpg", "cat4.jpg", "cat5.jpg", "dog1.jpg", "dog2.jpg", "dog3.jpg", "dog4.jpg", "dog5.jpg"];
Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 800 600]);

% constants
rectSize = 100; % distance between top-left and bottom-right corners of each rectangle
gridSize = 5; % number of rectangles per column
displaySize = rectSize*gridSize; % total pixels for display
    rectCount = 0;
    for x=1:rectSize:displaySize % goes through columns
        for y=1:rectSize:displaySize % goes through lines until display size is reached
        rectCount = rectCount + 1;
        myRects(rectCount,:) = [x y x+rectSize/2 y+rectSize/2]; % top left bottom right corners
        end
    end

inClick = false; % conditional variable for clicks inside rectangles
while inClick == false
    [Xmouse Ymouse buttons] = GetMouse;
    totalNumberRect = rectCount;
    for k=1:totalNumberRect % loops through myRects
        rect =  myRects(k,:);
        Screen(win, 'FillRect', [0 0 0], rect);
        thisImage = fileList(1);
        %showThis = fileList(thisImage);
        im = imread(thisImage);
        tex = Screen('MakeTexture', win, im);
        Screen('DrawTexture', win, tex, [], [x y x+rectSize/2 y+rectSize/2]);
        %Screen('DrawTexture', win, tex, [], [800+Xshift 600+Yshift 800-Xshift 600-Yshift]);
        Screen(win, 'flip');
        withinMyRects = Xmouse > rect(1) && Xmouse < rect(3) && Ymouse > rect(2) && Ymouse < rect(4);
        if withinMyRects && ...
            buttons(1)
            inClick = true;
        end
    end
    Screen(win, 'Flip');
end
sca
