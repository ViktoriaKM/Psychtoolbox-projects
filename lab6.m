
% warmup exercises  

% Given:
% Gender = "female"
% Height = 178
% a)Write a script that displays ’tall’ if height is greater than 175
gender = 'female';
height=178;
if height>175 & gender == 'female'
    disp('tall');
end

% b)Modify this cript to show 'tall' if height is greater than 175 and the person is a female
gender = 'female';
height=178;
if height>175 & gender=='female'
    disp('tall');
else
    disp('average');
end

% c)Use else to handle all these eventualities.
%   If a male is less than 175 display ‘short’.
gender = 'male';
height = 159;
if height<175 & gender == 'male'
    disp('short');
    %   If a male is greater than 175 display ‘average’.
else
    disp('average');
end

%   If a female is less than 175 display ‘average’.
gender = 'female';
if height < 175 & gender == 'female'
    disp('average');
%   If a female is less than 175 display ‘tall’.
else
    disp('tall');
end



%% -----ex 1 -----
% Use the information on the slide to recreate our original cat/dog experiment in PTB
% (give a lot of time for this)

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0,[127 127 127], [0 0 640 480]);
fileList=["cat1.jpg", "cat2.jpg", "cat3.jpg", "cat4.jpg", "cat5.jpg", "dog1.jpg", "dog2.jpg", "dog3.jpg", "dog4.jpg", "dog5.jpg"];

for kk = 1:10
    fileName = fileList(kk);
    im = imread(fileName);
    tex = Screen('MakeTexture', win, im);
    Screen('DrawTexture', win, tex, [], [0 0 300 200]);
    Screen(win, 'flip');
    
    [secs, keyCode] = KbStrokeWait;
    
end

sca
%% -----ex 2 -----
% If you have not already, use the index-variable of your for loop to create an array (record) of all 10 responses.
% Now, create a variable at the top of your experiment
% condition =['1' '1' '1' '1' '1' '2' '2' '2' '2' '2']
% Can you use and if statement, within your loop, to determine if a response is correct or not?

fileList=["cat1.jpg", "cat2.jpg", "cat3.jpg", "cat4.jpg", "cat5.jpg", "dog1.jpg", "dog2.jpg", "dog3.jpg", "dog4.jpg", "dog5.jpg"];
condition =['1', '1', '1', '1', '1', '2', '2', '2', '2', '2'];
response = strings(length(fileList),1);

Screen('Preference', 'SkipSyncTests', 1);
win = Screen('OpenWindow',0,[127 127 127], [0 0 640 480]);

all_resp = strings(1,10);

for kk = 1:10
    fileName = fileList(kk);
    im = imread(fileName);
    tex = Screen('MakeTexture', win, im);
    Screen('DrawTexture', win, tex);
    Screen(win, 'flip');
    
    [secs, keyArray] = KbStrokeWait;
    pressedKey = KbName(keyArray);
    all_resp(kk) = pressedKey(1);
    
    if (all_resp(kk) == condition(kk))
        disp('correct');
    else
        disp('incorrect');
    end
    
end

sca

%% -----ex 3 -----
% Randomization is an indispensable part of any lab. The matlab function randperm will create a sequence of random numbers.
% Find out how to use it (google or ‘help randperm’) to make new variable with 10 random numbers (one for each stimulus).


%% -----ex 4 -----
% Now within your loop, create new variable (e.g. ‘whichStim’) which access this variable on each iteration.
% Then, use this to access the image to be shown.

%% EXTRA  -----ex 5 ----- EXTRA
% Can you work out a way to calculate accuracy and record accuracy with the random order?