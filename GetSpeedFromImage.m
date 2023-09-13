function [speedMatrix, minColor, maxColor] = GetSpeedFromImage(filename, minSpeed, maxSpeed)

pic = imread(filename);

picSize = size(pic);
height = picSize(1);
width = picSize(2);

speedMatrix = zeros(height, width);

minColor = min(pic(:));
minColor = double(minColor);

maxColor = max(pic(:));
maxColor = double(maxColor);

for i = 1 : height
    for j = 1 : width
        speedMatrix(height - i + 1, j) = ConvertColorToSpeed(pic(i, j, 1), minColor, maxColor, minSpeed, maxSpeed);
    end
end