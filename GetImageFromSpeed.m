function picture = GetImageFromSpeed(speedMatrix, minColor, maxColor, minSpeed, maxSpeed)

speedSize = size(speedMatrix);
height = speedSize(1);
width = speedSize(2);

picture = zeros(height, width, 3, 'uint8');

for i = 1 : height
    for j = 1 : width
        color = ConvertSpeedToColor(speedMatrix(i, j), minColor, maxColor, minSpeed, maxSpeed);
        picture(height - i + 1, j, 1) = color;
        picture(height - i + 1, j, 2) = color;
        picture(height - i + 1, j, 3) = color;
    end
end