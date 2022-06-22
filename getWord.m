function typeWord = getWord(win)
typedWord = [];
while true
    [keyTime, keyCode] = KbStrokeWait();
    keyPressed = KbName(keyCode);
    if strcmp(keyPressed,'Return');
        break
    end
    typedWord = [typedWord keyPressed];
    DrawFormattedText(win, typedWord, 'center', 'center');
    Screen('Flip',win);
end