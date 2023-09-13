function color = ConvertSpeedToColor(speed, minColor, maxColor, minSpeed, maxSpeed)

color = uint8(255 * (maxSpeed - speed) / (maxSpeed - minSpeed));

%if (speed >= c0)
%    color = uint8(195 - (speed - 1.0) * (195 - 127) / 0.1);
%else
%    color = uint8(195 + (1.0 - speed) * (255 - 195) / 0.03);
%end

%c0Delta = c0Delta / 2;

%if (speed >= c0)
%    color = uint8(c0Color - (speed - c0) * (c0Color - minColor) / c0Delta);
%else
%    color = uint8(c0Color + (c0 - speed) * (maxColor - c0Color) / c0Delta);
%end

%color = uint8((speed - 1.0) * (maxColor - minColor) / 0.07 + minColor);
%color = uint8(round(speed - 1));