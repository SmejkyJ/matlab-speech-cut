function times = splitToSections(signal)
    sum = 0;
    for i = 1:numel(signal)
        sum = sum + signal(i);
    end
    offset = sum/32000;
    for i = 1:numel(signal)
        signal(i) = signal(i) - offset;
    end

    fs = 16000;
    frameDuration = 0.05;
    overlapPercentage = 90;
    frameLength = round(frameDuration * fs);
    overlap = round(frameLength * overlapPercentage / 100);
    numFrames = floor((length(signal) - overlap) / (frameLength - overlap));
    frames = zeros(frameLength, numFrames);
    startIndex = 1;
    for i = 1:numFrames
        endIndex = startIndex + frameLength - 1;
        frames(:, i) = signal(startIndex:endIndex);
        startIndex = endIndex - overlap + 1;
    end
    reducedFrames = struct('up', {}, 'down', {}, 'zero', {});
    highestValue = 0;
    for i = 1:size(frames, 2)
        values = struct('up', 0, 'down', 0, 'zero', 0);
        for s = 1:size(frames, 1)
            if (frames(s, i) > 0)
                values.up = values.up+frames(s, i);
            end
            if (frames(s, i) < 0)
                values.down = values.down+frames(s, i);
            end
        end
        values.down = values.down/size(frames, 1);
        values.up = values.up/size(frames, 1);
        if (abs(values.down) > highestValue)
            highestValue = abs(values.down);
        end
        if (values.up > highestValue)
            highestValue = values.up;
        end
        reducedFrames(end+1) = values;
    end
    for i = 1:numel(reducedFrames)
        if (abs(double(reducedFrames(i).up)+double(reducedFrames(i).down)) < ((double(reducedFrames(i).up)+abs(double(reducedFrames(i).down)))/2)*0.2) 
            if (reducedFrames(i).up < highestValue*0.08)
                reducedFrames(i).up = 0;
                reducedFrames(i).down = 0;
            end
            if (reducedFrames(i).down > -highestValue*0.08)
                reducedFrames(i).down = 0;
                reducedFrames(i).up = 0;
            end
        else
            reducedFrames(i) = struct('up', 0, 'down', 0, 'zero', 0);
        end
    end
    times = struct('first', 0, 'last', 0);
    lastNumberTime = 0;
    for i = 1:numel(reducedFrames)
        if (reducedFrames(i).up ~= 0 || reducedFrames(i).down ~= 0)
            if (times.first == 0)
                times.first = (i/numel(reducedFrames))*2;
            end
            times.last = (i/numel(reducedFrames))*2+0.06;
        end
    end
end

