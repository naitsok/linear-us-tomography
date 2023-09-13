function transducers = GenerateTransducers(numberOfTrans, transType)

if strcmp(transType, 'rectangle')
    transducers = GetTransCoordsRectangle(numberOfTrans);
end

if strcmp(transType, 'circle')
    transducers = GetSensorCoordsCircle(numberOfTrans);
end
    