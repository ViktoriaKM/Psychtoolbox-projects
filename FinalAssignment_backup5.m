 
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

% selects a random index from the list of image files
randIndexes = randperm(32);


% create an empty array to record the images shown  
recordedImages = [];
% and another for words
recordedWords = [];

freq = 44100;
pahandle = PsychPortAudio('Open', [], [], 0, freq, 1);


%exit button
buttonColor = [255 0 0];
buttonLocation = [0 0 80 30];
buttonClick = false;     
 
while buttonClick == 0
% check if the mouse location is within the exit button
[x y buttons]=GetMouse;
if buttons(1) && ...
    withinButton
disp(buttonClick);

	buttonClick = 1; % remains flase no matter where you click, is something wrong with getMouse?
	break
end        
        % First run is practice, everything in alphabetical order
        for idx=1:38
            % access all media from the file lists
            thisImage = imageList(idx);
            thisWord = wordList(idx);


            Screen('FillRect',win, buttonColor, buttonLocation);
            withinButton = x>buttonLocation(1) & x<buttonLocation(3) & y>buttonLocation(2) & y<buttonLocation(4);
            DrawFormattedText(win, 'EXIT', 'left',...
            800 * 0.03, [0 0 1]);

            if buttons(1) && ...
                    withinButton
                buttonClick = 1; % remains flase no matter where you click, is something wrong with getMouse?
                break
            end
            Screen(win, 'Flip', [],1);
            %disp(withinButton)
            disp(buttonClick)
            disp(x)
            disp(y)
            disp(thisWord);
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
    sca;



%% The actual test

win = Screen('OpenWindow',0, [127 127 127],[0 0 width height]);

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
	%incorrect = strcat(incorrect," ",textString);
    incorrect = [incorrect, " ", textString];
    %disp(incorrect);
    end

    % Display number of correct answers
    points = ['You have: '  num2str(numCorrect)  ' points.'];
    DrawFormattedText(win,  points, 'center',...
            800 * 0.85, [0 0 1]);
end

% To-do:


% store the responses in a table, including no. of errors until correct

% handle errors: if a wrong answer is given, re-display image (max 3
% attempts per image)


% convert incorrect to a suitable data structure to match the words  with images 
 %incorrectCellArr = textscan(incorrect,'%s','Delimiter',' ')
%%  display incorrect images  again with audio letteres
wavLetters = ["a.wav","b.wav","c.wav","d.wav","e.wav","f.wav","g.wav","h.wav","i.wav","j.wav","k.wav","l.wav","m.wav","n.wav","o.wav","p.wav","q.wav","r.wav","s.wav","t.wav","u.wav","v.wav","x.wav","y.wav","z.wav"];
win = Screen('OpenWindow',0, [127 127 127],[0 0 width height]);
letterfiles = dir('letters/*.wav');
freq = 44100;
pahandle = PsychPortAudio('Open', [], [], 0, freq, 1);


for  i=2:2:length(incorrect)/2 % pick out the words from the string array, ignoring blankspaces
    % match with images to show again
    %disp(incorrect(i));
    imageMatch = strcat(incorrect(i),'.jpg');
    wordMatch = convertStringsToChars(incorrect(i));
    disp(imageMatch);
    %strfind(imageList,imageMatch)
    % find image
    for k=1:length(imageList)
         if imageList(k)==imageMatch
             
             % show the image
             im = imread(imageList(k));
             tex = Screen('MakeTexture', win, im);
             Screen('DrawTexture', win, tex, [], [left top right bottom]);
             Screen(win, 'flip');
             pause(0.2);
             % read the letters corresponding to the incorrect words
             disp(wordMatch)
             for letter=1:length(wordMatch)
                thisLetter = upper(wordMatch(letter));
                    for wavLetter=1:length(letterfiles)
                        thisLetter = strcat(thisLetter, '.wav');
                                if thisLetter == letterfiles(wavLetter).name
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





