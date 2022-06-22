clear all 
close all
clc

% constant
bgColor = [127 127 127];
screenSize=[0 0 640 480];
cursorColor = randperm(255, 3);
cursorRadius = 5;

Screen('Preference', 'SkipSyncTests', 1);
[win screenRect] = Screen('OpenWindow', 0, bgColor, screenSize);

% execute
noClickYet = true;
while true
    [x y buttons]=GetMouse(win);
    Screen('FillOval', win, cursorColor, [x-cursorRadius y-cursorRadius x+cursorRadius y+cursorRadius]);
    Screen('Flip', win, [], 1);
    if buttons(1) == 1
        break
    end
    if buttons(2) == 1
        cursorColor = randperm(255, 3);
    end
    oneRect=[50 50 150 100];
    Screen('FillRect', win, [64 64 0],  [50 50 100 50]);
    % check if cursor is inside rectangle
    if x>oneRect(1) & x<oneRect(3) & y>oneRect(2) & y<oneRect(4)
    noClickYet = false;
    end
end
sca


%% ---- ex 1 ----
% Write a script that tracks the location of the mouse (drawing), and exits if the left button is pressed
%  

% See Davids recording of lecture 10

%% ---- ex 2 ----
% Modify this so that the mouse size increases if the right button is pressed. Now change this so the colour changes instead.
cursorColor = randperm(255, 3);
cursorRadius = 50;
sizeIncrement = 5;
Screen('Preference', 'SkipSyncTests', 1);
[win screenRect] = Screen('OpenWindow', 0, bgColor, screenSize);
while true
    [x y buttons]=GetMouse;
    Screen('FillOval', win, cursorColor, [x-cursorRadius y-cursorRadius x+cursorRadius y+cursorRadius]);
    Screen(win, 'Flip', [],1);
    if buttons(1)
        break
    end
    if buttons(2)
        cursorRadius = cursorRadius + sizeIncrement;
        pause(0.1);
        % change color
        cursorColor = randperm(255, 3);
    end
end
sca
%% ---- ex 3 ----
% It takes a little bit of a creative problem solving. Modify the script so that a mouse click turns the cursor into an eraser that erases the drawing when it passes over.
% 
bgColor = [127 127 127];
cursorColor = randperm(255, 3);
cursorRadius = 50;
sizeIncrement = 5;
Screen('Preference', 'SkipSyncTests', 1);
[win screenRect] = Screen('OpenWindow', 0, bgColor, screenSize);
while true
    [x y buttons]=GetMouse;
    Screen('FillOval', win, cursorColor, [x-cursorRadius y-cursorRadius x+cursorRadius y+cursorRadius]);
    Screen(win, 'Flip', [],1);
    if buttons(1)
        cursorColor = bgColor;
    end

end
sca
%% ---- ex 4 ----
% Can you code up an ‘exit’ button?
buttonColor = [50 30 0];
buttonLocation = [600 460 640 480];
buttonClick = false;
bgColor = [127 127 127];
cursorColor = randperm(255, 3);
cursorRadius = 50;
sizeIncrement = 5;
Screen('Preference', 'SkipSyncTests', 1);
[win screenRect] = Screen('OpenWindow', 0, bgColor, screenSize);
while true
    [x y buttons]=GetMouse;
    Screen('FillOval', win, cursorColor, [x-cursorRadius y-cursorRadius x+cursorRadius y+cursorRadius]);
    Screen('FillRect',win, buttonColor, buttonLocation);
    % unfortunately this makes Matlab crash...
    %DrawFormattedText(win, 'EXIT', 460, 640);
    Screen(win, 'Flip', [],1);
    if buttons(1)
        cursorColor = bgColor;
    end
    if x>buttonLocation(1) & x<buttonLocation(3) & y>buttonLocation(2) & y<buttonLocation(4)
        buttonClick = true;
        % fix hovering problem (see Davids recording 10)
        break
    end

end
sca