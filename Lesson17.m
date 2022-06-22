%% % Exercise 1 % %%
%Finish last weeks exercise

%% % Exercise 2 % %%
%Code a simple staircase experiment for a single frequency. Record the SNR for each trial and calculate the threshold using the last 5 trials.
clear
samplingRate = 48000; % samples per second

condition = 500; % ocsillations per  second
duration =.5;
nTrials = 10;
mySNR=.1; % initial value (shrinks intensity of noise)


%devices =  PsychPortAudio('GetDevices');

InitializePsychSound(1);
[beep] = MakeBeep(condition,duration,samplingRate);

pahandle = PsychPortAudio('Open', [], [], [], samplingRate,1);


allSNR = zeros(1, nTrials);
noise = rand(size(beep));
for trial=1:nTrials
    allSNR(trial) = mySNR;
    % have the script wait for .5 sec
    pause(.5);
    stimulus = noise + mySNR*beep;
    % make the stimulus for this particular SNR
    PsychPortAudio('FillBuffer', pahandle, stimulus);
    PsychPortAudio('Start', pahandle);
    % collect and interpret a keypress
    [~, keyCode] = KbStrokeWait;
    keyName = KbName(keyCode);
    if keyName(1)=='q'
        disp('exiting')
        break
    elseif keyName(1) == '1' % indicates that they heard  the stimulus, we make it harder
        mySNR = mySNR*.9;  %  reduce mySNR by 10%
    elseif keyName(1) == '2' % if they did not hear, we make it easier by increasing i t
        mySNR = mySNR*1.1;
    end
    % otherwise we preserve it
    % keepSNR(trial) = mySNR;
    % keepPitch(trial) = pitch;
end
    figure;
    stairs(allSNR);
    thresh = mean(allSNR(nTrials-4:nTrials));
    
%% % Exercise 3 % %% (for Friday lab)
%Adapt exercise 2 to assess the threshold SNR for four different frequencies. 
%Store the SNR for each trial and each condition (frequency) in a matrix.
%Calculate the SNR for each frequency.
%If there is time, collate the results of you group, and with the help of your tutor, try graphing and analyzing these results. 
clear
duration =.5;
samplingRate = 48000; % samples per second
picth=[500, 1000, 1500, 2000]; % frequencies in Hz
nPitches = 4;

nTrials = 20; % trials per condition
allSNR = zeros(nPitches,nTrials);

nTrials = 10;  
for condition = 1:nPitches
    % define the beep for each condition
    [beep] = MakeBeep(picth(condition),duration,samplingRate);
    
    mySNR = .1; % initial value for this condition
    pahandle = PsychPortAudio('Open', [], [], [], samplingRate,1);
    
    % make allSNR into a matrix, the idea is to have all the conditions as rows
    % and trials as columns.  Every value in the matrix would
    % represent a trial within a condition
    %ConditionRow = zeros(conditionCode(condition), nTrials);
    %disp(allSNR);
    %noise = rand(size(beep));
    
    for trial=1:nTrials
        allSNR(condition,trial) = mySNR;
        noise = .1*randn(size(beep));
        % have the script wait for .5 sec
        pause(.5);
        stimulus = noise + mySNR*beep;
        % make the stimulus for this particular SNR
        PsychPortAudio('FillBuffer', pahandle, stimulus);
        PsychPortAudio('Start', pahandle);
        % collect and interpret a keypress
        [~, keyCode] = KbStrokeWait;
        keyName = KbName(keyCode);
        if keyName(1)=='q'
            disp('exiting');
            break
        elseif keyName(1) == '1' % indicates that they heard  the stimulus, we make it harder
            mySNR = mySNR*.9;  %  reduce mySNR by 10%
        elseif keyName(1) == '2' % if they did not hear, we make it easier by increasing i t
            mySNR = mySNR*1.1;
        end

    end
    figure;
    stairs(allSNR(condition,:));
    xlabel('trials');
    ylabel('mySNR');

    
end

thresh = mean(allSNR(nTrials-4:nTrials),2);
