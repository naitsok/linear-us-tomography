function speed = ConvertColorToSpeed(color, minColor, maxColor, minSpeed, maxSpeed)

speed = maxSpeed - double(color) * (maxSpeed - minSpeed) / 255;

%c0Delta = c0Delta / 2;
%color = double(color);

%if (color <= c0Color)
%    speed = c0 + c0Delta * (c0Color - color) / (c0Color - minColor);
%else
%    speed = c0 - c0Delta * (color - c0Color) / (maxColor - c0Color);
%end

%speed = 1.0 + double(color - minColor) * 0.07 / double(maxColor - minColor);
%speed = double(color) + 1;