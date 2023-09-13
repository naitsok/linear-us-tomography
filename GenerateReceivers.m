function receivers = GenerateReceivers(numberOfRec, recType)

if strcmp(recType, 'rectangle')
    receivers = GetRecCoordsRectangle(numberOfRec);
end

if strcmp(recType, 'circle')
    receivers = GetSensorCoordsCircle(numberOfRec);
end