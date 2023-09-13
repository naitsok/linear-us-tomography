function sensors = GetSensorCoordsCircle(numberOfSensors)

%numberOfSensors = floor(numberOfSensors / 2);

sensors = [0, 0];

for i = 1 : numberOfSensors
    sensors(i, 1) = (cos(2 * pi * (i - 1) / numberOfSensors) + 1) / 2;
    sensors(i, 2) = (sin(2 * pi * (i - 1) / numberOfSensors) + 1) / 2;
end

%wholeIndex = 1;
%for i = 1 : numberOfTrans
%    x = (i - 1) / (numberOfTrans - 1);
    
%    if (x <= 0.0 + precision)
%        sensors(wholeIndex, 1) = 0;
%        sensors(wholeIndex, 2) = 0.5;
%        wholeIndex = wholeIndex + 1;
        
%        sensors(wholeIndex, 1) = 0.5;
%        sensors(wholeIndex, 2) = 0;
%        wholeIndex = wholeIndex + 1;
%        continue;
%    end
    
%    if(x >= 1.0 - precision)
%        sensors(wholeIndex, 1) = 1;
%        sensors(wholeIndex, 2) = 0.5;
%        wholeIndex = wholeIndex + 1;
        
%        sensors(wholeIndex, 1) = 0.5;
%        sensors(wholeIndex, 2) = 1;
%        wholeIndex = wholeIndex + 1;
%        continue;
%    end
    
%    sensors(wholeIndex, 1) = x;
%    sensors(wholeIndex, 2) = 0.5 + sqrt(0.25 - (x - 0.5)^2);
%    wholeIndex = wholeIndex + 1;
    
%    sensors(wholeIndex, 1) = x;
%    sensors(wholeIndex, 2) = 0.5 - sqrt(0.25 - (x - 0.5)^2);
%    wholeIndex = wholeIndex + 1;
%end