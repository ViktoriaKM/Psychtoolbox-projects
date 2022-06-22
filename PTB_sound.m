samplingRate = 44100; % qulity of sound (analoguos to resolution)
pitch = 500; % Hz
duration = 0.5; % 500 msec
[beep] = MakeBeep(pitch,duration,samplingRate);
plot(beep);
sound(beep, samplingRate); % matlab function, not PTB

% use PTB to play a beep:
InitializePsychSound(1);
% PTB auditory equivalent of Screen('Open'...)
pahandle = PsychPortAudio('Open', [], [], [], samplingRate,1);
% fill the buffer (like MakeTexture and DrawTexture)
PsychPortAudio('FillBuffer', pahandle, beep);
% play the buffer (kind of like flip)
%% 

clear 
clc
close all
samplingRate = 22050;
duration = 0.5;
pitch = 1000;
[beep] = MakeBeep(pitch, duration, samplingRate);
sampleDuration = 1/samplingRate; % how wide is a pixel
xValues = sampleDuration:sampleDuration:duration; % how long is the sample duration: step increase : length of sound in time
plot(xValues);
plot(beep);
plot(xValues,beep);
xlabel('time');
xlim([0 .05]);
%drawnow % not necessary now
%% 

InitializePsychSound(1);  
% PTB auditory equivalent of Screen('Open'....)
pahandle = PsychPortAudio('Open', [], [], [], samplingRate,1);% like ‘win’
% fill the buffer (like MakeTexture and DrawTexture)
PsychPortAudio('FillBuffer', pahandle, beep);
% play the buffer (kind of like flip)
PsychPortAudio('Start', pahandle)

%% Warm up

% given 2 conditioins
conditionCode = Shuffle([1 2]); % Shuffle is an easier alternative to randperm
% relating 2 pitches
myPitches = [500 1500];
% we want to present each pitch 5 times in a row
% randomize which pitch will be presented first
% store which pitch was presented (fill for SNR)
for condition=conditionCode
    for trial=1:5
        pitch = myPitches(condition)+rand*100;
        myPitches(condition);
        %store the presented picth for this trial
        [beep] = MakeBeep(pitch, howLong, samplingRate);
        PsychPortAudio('FillBuffer', pahandle, beep/3);
        PsychPortAudio('Start', pahandle);
        whichPitch(condition, trial)=pitch;
    end
end


%% Make a simple staircase threshold
InitializePsychSound(1);
samplingRate = 44100;
pahandle = PsychPortAudio('Open', [], [], [], samplingRate);
pitch = 500;
howLong =.5;

mySNR=.1; % initial value (shrinks intensity of noise)
for trial=1:20
    pause(.5);
    % have the script wait for .5 sec
    % make the stimulus for this particular SNR
    PsychPortAudio('FillBuffer', pahandle, stimulus);
    PsychPortAudio('Start', pahandle);
    % collect and interpret a keypress
    if keyName(1)=='q'
        disp('exiting')
        break
    elseif keyName(1) == '1'; % indicates that they heard  the stimulus, we make it harder
        mySNR = mySNR*.9;  %  reduce mySNR by 10%
    elseif keyName(1) == '2'; % if they did not hear, we make it easier by increasing i t
        mySNR = mySNR*1.1;
    end
    % otherwise we preserve it
    keepSNR(trial) = mySNR;
    keepPitch(trial) = pitch;
    end
    

    %% Design a version of this test to test whether different frequencies are more detectable 
    % run 4 separate staircases for each frequency (500 1000 1500 2000)
    % order should be randomized
    
    %% Aside: reading with wav-files and mp3
    InitializePsychSound(1);
    [y, Fs] = psychwavread('a.wav');
    [data, samplingRate] = audioread('a.wav');
    pahandle = PsychPortAudio('Open', [], [], [], samplingRate,1);
    PsychPortAudio('FillBuffer', pahandle, data);
    %PsychPortAudio('Start', pahandle, data);
     
