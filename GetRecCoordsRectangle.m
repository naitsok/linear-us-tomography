function receivers = GetRecCoordsRectangle(numberOfRec)

%Number of receivers per side
numberOfRec = floor(numberOfRec / 4);

%x0 = 0;
%y0 = 0.5;

receivers = [0, 0];
wholeIndex = 1;

for index = 1 : numberOfRec
    receivers(wholeIndex, 1) = index / numberOfRec;
    receivers(wholeIndex, 2) = 1;
    wholeIndex = wholeIndex + 1;
end

for index = 1 : numberOfRec
    receivers(wholeIndex, 1) = 0;
    receivers(wholeIndex, 2) = index / numberOfRec;
    wholeIndex = wholeIndex + 1;
end

for index = 1 : numberOfRec
    receivers(wholeIndex, 1) = 1;
    receivers(wholeIndex, 2) = 1 - index / numberOfRec;
    wholeIndex = wholeIndex + 1;
end

for index = 1 : numberOfRec
    receivers(wholeIndex, 1) = 1 - index / numberOfRec;
    receivers(wholeIndex, 2) = 0;
    wholeIndex = wholeIndex + 1;
end