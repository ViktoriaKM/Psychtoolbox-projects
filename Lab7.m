

%% ex 1 create a version of the script
clear 
Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 800 600]);

% constants
rectSize = 100; % pixels
gridSize = 5;
displaySize = rectSize*gridSize;

rectCount = 0;
for x=1:rectSize:displaySize
    for y=1:rectSize:displaySize
        rectCount = rectCount + 1;
        myRects(rectCount,:) = [x y x+rectSize/2 y+rectSize/2];
    end
end

%% ex 2 change the number of rectangles

totalNumberRect=rectCount;
for k=1:totalNumberRect
    Screen(win,'FillRect',[0 0 0],myRects(k,:));
end
Screen(win,'Flip') 
KbStrokeWait;
sca

