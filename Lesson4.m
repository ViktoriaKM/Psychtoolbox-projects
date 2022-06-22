%% ex 1 Open a PTB window. Try to change the size and colour

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [255 127 0],[0 0 800 600]);
%% ex 2 Draw a coloured rectangle. Flip it onto the screen. Change
%%the size and colour 

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 640 480]);

Screen('FillRect', win, [0 0 255], [240 400 440 600]);

%% ex 3 Draw multiple shapes and flip them onto the screen. Try to design an interesting shape

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 640 480]);

Screen('FillOval',win,[0 255 0],[50 100 150 150]);
Screen('FillOval',win,[0 255 0],[440 100 540 150]);
Screen('Flip', win);

%% ex 4 Use a for loop and animate a shape over time
Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 640 480]);

for ii=1:200
    Screen('FillRect',win,[255 0 0],[50 50 100 100]+ii);
    Screen('Flip',win);
end
pause(1);
sca

%%  ex 5 Use this for-loop to animate the colour of the shape/s

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 640 480]);

for ii=1:200
    Screen('FillRect',win,[255 0 0],[50+ii 50 100+ii 100]);
    Screen('Flip',win);
end
pause(1);
sca

%% ex 6 Using your knowledge of the coordinate system, can you make the shape move only horizontally?

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 640 480]);
for ii=1:200
    Screen('FillRect',win,[255 0 0], [ii 50 ii 100]+ii);
    Screen('Flip', win);
end
pause(1);
sca

