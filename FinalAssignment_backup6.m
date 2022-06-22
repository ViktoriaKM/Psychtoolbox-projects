% Disclaimer: There are some parts I would have liked to work more on (eg. the exit button) and
% ideas that I did not have time to implement (such as storing scores in a
% table and cleaning up the interface). However, I hope to continue working
% on this as a learning experience. In  regards to this current version,
% the sound  files need to be separated with the letters in their own
% folder for the first and third parts to play only the words or letters respectively.

%% Part 1: Practice 


% Clear the workspace and the screen
close all;
clearvars;
sca

% Prevent crash
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference','TextRenderer',0);

% File lists
imageList = ["ant.jpg","axe.jpg","banana.jpg","bat.jpg","belt.jpg","brush.jpg","canary.jpg","cape.jpg","cat.jpg","cherry.jpg","dog.jpg","dress.jpg","duck.jpg","eagle.jpg","fox.jpg","goat.jpg","goose.jpg","hat.jpg","jacket.jpg","kiwi.jpg","koala.jpg","ladder.jpg","lemon.jpg","lion.jpg","mole.jpg","peach.jpg","pencil.jpg","penguin.jpg","pig.jpg","pumpkin.jpg","rabbit.jpg","sheep.jpg", "shirt.jpg", "skunk.jpg", "swan.jpg", "tiger.jpg", "tomato.jpg", "zebra.jpg"];
wordList = ["ant","axe","banana","bat","belt","brush","canary","cape","cat","cherry","dog","dress","duck","eagle","fox","goat","goose","hat","jacket","kiwi","koala","ladder","lemon","lion","mole","peach","pencil","penguin","pig","pumpkin","rabbit","sheep", "shirt", "skunk", "swan", "tiger", "tomato", "zebra"];
wavWords = ['ant.wav','axe.wav','banana.wav','bat.wav','belt.wav','brush.wav','canary.wav','cape.wav','cat.wav','cherry.wav','dog.wav','dress.wav','duck.wav','eagle.wav','fox.wav','goat.wav','goose.wav','hat.wav','jacket.wav','kiwi.wav','koala.wav','ladder.wav','lemon.wav','lion.wav','mole.wav','peach.wav','pencil.wav','penguin.wav','pig.wav','pumpkin.wav','rabbit.wav','sheep.wav','shirt.wav','skunk.wav', 'swan.wav', 'tiger.wav', 'tomato.wav', 'zebra.wav'];

% Create a data-structure with the soundfiles in the current directory
soundfiles = dir('*.wav');

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

freq = 44100;
pahandle = PsychPortAudio('Open', [], [], 0, freq, 1);


%exit button
buttonColor = [255 0 0];
buttonLocation = [0 0 80 30];
buttonClick = false;     
 
while buttonClick == 0

        for idx=1:38
            % access all media from the file lists in alphabetical order
            thisImage = imageList(idx);
            thisWord = wordList(idx);
            % check if the mouse location is within the exit button
            Screen('FillRect',win, buttonColor, buttonLocation);
            DrawFormattedText(win, 'EXIT', 'left',...
            800 * 0.03, [0 0 1]);
            [x y buttons]=GetMouse;
            withinButton = x>buttonLocation(1) & x<buttonLocation(3) & y>buttonLocation(2) & y<buttonLocation(4);
            if buttons(1) && ...
                withinButton

                buttonClick = 1; % remains flase no matter where you click, is something wrong with getMouse?
                break
            end 

            Screen('TextSize', win, 90);
            Screen('TextFont', win, 'Times');
            textString = num2str(thisWord);

            DrawFormattedText(win, textString, 'center',...
            800 * 0.85, [0 0 1]);
            
            im = imread(thisImage);
            tex = Screen('MakeTexture', win, im);
            Screen('DrawTexture', win, tex, [], [left top right bottom]);
            Screen(win, 'flip');

            % for sounds
            presentfile = soundfiles(idx).name;
            [audiodata, freq] = audioread(presentfile);
            PsychPortAudio('FillBuffer', pahandle, audiodata');
            PsychPortAudio('Start', pahandle);
            pause(2);

        end

end




%% Part 2: The actual test

win = Screen('OpenWindow',0, [127 127 127],[0 0 width height]);

% selects a random index from the list of image files
randIndexes = randperm(32);

% record  responses:
numCorrect = 0;
incorrect = [];

for idx=1:38
    % access all media from the file lists
    thisImage = imageList(randIndexes(idx));
    thisWord = wordList(randIndexes(idx));
    im = imread(thisImage);
    tex = Screen('MakeTexture', win, im);
    Screen('DrawTexture', win, tex, [], [left top right bottom]);
    Screen(win, 'flip');
    pause(0.2);
   
    inputWord=input('Type the word for this image: ','s');

    Screen('TextSize', win, 50);
    Screen('TextFont', win, 'Times');
    textString = num2str(thisWord);
    
    % check if the input word matches the image displayed
    if inputWord == thisWord
        numCorrect = numCorrect + 1;
    else
    % Record incorrect responses as strings
    incorrect = [incorrect, " ", textString];
    end

    % Display number of correct answers
    points = ['You have: '  num2str(numCorrect)  ' points.'];
    DrawFormattedText(win,  points, 'center',...
            800 * 0.85, [0 0 1]);
end
sca;

%%  Part 3: display incorrect images  again with audio letters

win = Screen('OpenWindow',0, [127 127 127],[0 0 width height]);

% the letter audio files are located in a separate folder inside the
% working directory
letterfiles = dir('*/*.wav');
freq = 44100;
pahandle = PsychPortAudio('Open', [], [], 0, freq, 1);


for  i=2:2:length(incorrect)/2 % pick out the words from the string array, ignoring blankspaces
    
    % match with images to show again
    imageMatch = strcat(incorrect(i),'.jpg');
    wordMatch = convertStringsToChars(incorrect(i));
 
    % find image
    for k=1:length(imageList)
         if imageList(k)==imageMatch
             % show the images and correct words
             Screen('TextSize', win, 90);
             Screen('TextFont', win, 'Times');
             DrawFormattedText(win, wordMatch, 'center',...
             800 * 0.85, [0 0 1]);
             im = imread(imageList(k));
             tex = Screen('MakeTexture', win, im);
             Screen('DrawTexture', win, tex, [], [left top right bottom]);
             Screen(win, 'flip');
             pause(0.2);
             
             % read the letters corresponding to the incorrect words
             for letter=1:length(wordMatch)
                thisLetter = upper(wordMatch(letter));
                    for wavLetter=1:length(letterfiles)
                        thisWavLetter = strcat(thisLetter, '.wav');
                        if thisWavLetter == letterfiles(wavLetter).name
                        	playLetter = letterfiles(wavLetter).name; 
                            [audiodata, freq] = audioread(playLetter);
                            PsychPortAudio('FillBuffer', pahandle, audiodata');
                            PsychPortAudio('Start', pahandle);
                            pause(1);
                        end
                          	
                               
                    end
                 
             end
         end
    end

end





