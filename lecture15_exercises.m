%% % Exercise 1 % %%
% Use psychtoolbox functions to create and play a beep.

% devices = PsychPortAudio('GetDevices', [], []);

samplingRate = 44100;
pitch = 500;
duration = .5;
[beep] = MakeBeep(pitch, duration, samplingRate);

% noise = randn(size(beep));
% noisyBeep = beep + noise;

InitializePsychSound(1);
% PTB auditory equivalent of Screen('Open'...)
pahandle = PsychPortAudio('Open', [], [], [], samplingRate, 1); % like 'win'


noise = randn(size(beep));
noisyBeep = beep + noise;

% fill the buffer (like MakeTexture and DrawTexture)
PsychPortAudio('FillBuffer', pahandle, noisyBeep);
% play the buffer (kind of like flip)
PsychPortAudio('Start', pahandle);

%% % Exercise 2 % %%
% Can you use some simple math to change the volume of the beep?

% Volume corresponds to amplitude, which is part of the beep variable.
% If we multipy by a constant, the amplitude will change.

volChange = 0.1;
beep2 = volChange*beep;
PsychPortAudio('FillBuffer', pahandle, beep2);
PsychPortAudio('Start', pahandle);
%% % Exercise 3 % %%
% Use the code on slide 11 to write a loop that increases the pitch of a beep from 100 to 2000 in steps, plotting the sound at the same time. 
clear
clc
close all
samplingRate = 22050; % quality of sound
duration=.5; %500 msec
pitch=500; %Hz

for i=100:50:2000
    [beep] = MakeBeep(pitch,duration,samplingRate);
    sampleDuration = 1/samplingRate;
    xValues = sampleDuration:sampleDuration:duration;
    xlim([0 .05])
    drawnow 

    InitializePsychSound(1); 
    pahandle = PsychPortAudio('Open', [], [], [], samplingRate,1);
    PsychPortAudio('FillBuffer', pahandle, beep);
    PsychPortAudio('Start', pahandle)
    WaitSecs(.6) 
    
end

%% % Exercise 4 % %%
% Write some code to make a beep then add some noise to this. Play around with different signal (beep) to noise ratios

SNR = 2; % Signal to Noise ratio (constant)
newBeep  = SNR*beep;
