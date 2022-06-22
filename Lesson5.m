% ex 1 Open a PTB window.
%Load an image, create a ‘texture’
%draw the texture
%Flip it on screen
%Pause for a second 
%Close the screen


Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 640 480]);
myImage = imread('cat1.jpg');
tex = Screen('MakeTexture', win, myImage);
Screen('DrawTexture', win, tex);
Screen(win,'flip');
pause(1);
sca;

%% ex 2 Take ex1 above 
%Now make it so the image displays until a button is pressed
Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 640 480]);
myImage = imread('cat1.jpg');
tex = Screen('MakeTexture', win, myImage);
Screen('DrawTexture', win, tex);
Screen(win,'flip');

x = input('Press 1 to stop displaying the image');
pause(x);
sca;

%% ex 3 Draw the image in a specific location

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 640 480]);
myImage = imread('cat1.jpg');
tex = Screen('MakeTexture', win, myImage);
Screen('DrawTexture', win, tex, [], [0 0 400 200]);
Screen(win,'flip');
pause(1);
sca;

%% ex 4 Can you draw multiple images on the same screen (or the same image multiple times

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 640 480]);
myImage1 = imread('cat1.jpg');
myImage2 = imread('cat2.jpg');
tex1 = Screen('MakeTexture', win, myImage1);
tex2 = Screen('MakeTexture', win, myImage2);
Screen('DrawTexture', win, tex1, [], [0 0 400 200]);
Screen('DrawTexture', win, tex2, [], [320 0 640 200]);
Screen(win,'flip');
pause(1);
sca;

%% ex 5 Can you use a for loop to draw a moving image?

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0, [127 127 127],[0 0 640 480]);
myImage = imread('cat1.jpg');
tex = Screen('MakeTexture', win, myImage);
for ii=1:200
    Screen('DrawTexture', win, tex, [], [0+ii 0 400+ii 200]);
    Screen(win,'flip');
end 
