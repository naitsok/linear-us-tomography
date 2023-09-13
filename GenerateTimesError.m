function times = GenerateTimesError(times, delta, averageNumber)

if averageNumber < 1
    error('number to average must be 1 or higher');
end

maxRow = max(times, [], 1);

maxTime = maxRow(5);

for index = 1 : size(times)
    
    tempTime = times(index, 5);
    sumTimes = 0;
    
    for avNum = 1 : averageNumber
        sumTimes = sumTimes + tempTime + random('unif', -1, 1) * delta * maxTime;
    end
    
    times(index, 5) = sumTimes / averageNumber;
end;