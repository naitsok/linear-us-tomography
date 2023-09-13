function transducers = GetTransCoordsRectangle(numberOfTrans)

numberOfTrans = floor(numberOfTrans / 4);

transducers = [0, 0];

wholeIndex = 1;
for index = 1 : numberOfTrans
    transducers(wholeIndex, 1) = index / (numberOfTrans + 1);
    transducers(wholeIndex, 2) = 1;
    wholeIndex = wholeIndex + 1;
end

for index = 1 : numberOfTrans
    transducers(wholeIndex, 1) = 1;
    transducers(wholeIndex, 2) = 1 - index / (numberOfTrans + 1);
    wholeIndex = wholeIndex + 1;
end

for index = 1 : numberOfTrans
    transducers(wholeIndex, 1) = 1 - index / (numberOfTrans + 1);
    transducers(wholeIndex, 2) = 0;
    wholeIndex = wholeIndex + 1;
end

for index = 1 : numberOfTrans
    transducers(wholeIndex, 1) = 0;
    transducers(wholeIndex, 2) = index / (numberOfTrans + 1);
    wholeIndex = wholeIndex + 1;
end