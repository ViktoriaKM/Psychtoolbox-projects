%% % Exercise 1 % %%
% write a PTB script to handle text input
% It should:
%  - Only quit if return is entered 
%  - Concatenate a string every time a key is pressed
%  - Show string in PTB
%  - Record final string when enter is pressed

Screen('Preference','SkipSyncTests',1);
Screen('Preference','TextRenderer',1);
[win, screenRect] = Screen('OpenWindow',0,[127 127 127],[0 0 640 480]);
keyPressed = [];
typedTxt = [];
while true
    [~, keyCode] = KbStrokeWait();
    letter = KbName(keyCode)     %<— take this ; off to see what the ‘letter' actually is. Is it a case sensitive match for ‘Return'
    typedTxt = [typedTxt letter];
    %if strcmp(letter,'return')
        % break loop if return key is pressed
     %   break
    %else
        %Screen('DrawText', win, letter);
        %DrawFormattedText(win,typedTxt, 'center', 'center');
        Screen('TextSize', win, 90);
        Screen('TextFont', win, 'Times');
        letter = num2str(letter);
        DrawFormattedText(win, letter, 'center',...
        640 * 0.85, [0 0 1]);
        Screen('Flip',win);   
    %end
    
   
end