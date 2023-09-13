%function [A, dx, dy] = GetPointMatrix(dimX, dimY, precision, x0, x1, y0, y1)

%dimentions
dimX = 500;
dimY = 500;
precision = eps('double') * 10;%1e-6;eps

x0 = 0;%0.501;
y0 = 0;%0;
x1 = 0.5;%0.607;
y1 = 1;%1;

dx = 1 / dimX;
dy = 1 / dimY;

rowNum = floor(x0 / abs(dx));
colNum = floor(y0 / abs(dy));

%if abs(x0 - 1) < precision
%    rowNum = rowNum - 1;
%end

%if abs(y0 - 1) < precision
%    colNum = colNum - 1;
%end

A = [x0, y0, rowNum + 1, colNum + 1];
if abs(x0 - x1) < precision
    y = colNum * dy;
    dy = sign(y1 - y0) * dy;
    index = 1;
    while abs(y - y1) > abs(dy)
        y = y + dy;
        A(index + 1, 1) = x0;
        A(index + 1, 2) = y;
        A(index + 1, 3) = rowNum + 1;
        A(index + 1, 4) = floor(y * dimY + precision / dimY) + 1;
        index = index + 1;
    end
    A(index + 1, 1) = x0;
    A(index + 1, 2) = y1;
    A(index + 1, 3) = rowNum + 1;
    A(index + 1, 4) = floor(y1 * dimY + precision / dimY) + 1;

elseif abs(y0 - y1) < precision
    x = rowNum * dx;
    dx = sign(x1 - x0) * dx;
    index = 1;
    while abs(x - x1) > abs(dx)
        x = x + dx;
        A(index + 1, 1) = x;
        A(index + 1, 2) = y0;
        A(index + 1, 3) = floor(x * dimX + precision / dimX) + 1;
        A(index + 1, 4) = colNum + 1;
        index = index + 1;
    end
    A(index + 1, 1) = x1;
    A(index + 1, 2) = y0;
    A(index + 1, 3) = floor(x1 * dimX + precision / dimX) + 1;
    A(index + 1, 4) = colNum + 1;
else

    k = (y1 - y0) / (x1 - x0);

    dx = sign(x1 - x0) * dx;
    dy = sign(y1 - y0) * dy;

    x = 0;
    if (dx < 0)
        x = rowNum * abs(dx);
        if (x0 == x)
            x = x - abs(dx);
        end
    end
    if (dx > 0)
        x = rowNum * abs(dx) + dx;
    end

    y = 0;
    if (dy < 0)
        y = colNum * abs(dy);
        if (y0 == y)
            y = y - abs(dy);
        end
    end
    if (dy > 0)
        y = colNum * abs(dy) + dy;
    end

    %A = [x0, y0, rowNum, colNum];
    index = 1;
    tempX = -1;
    while 1
        tempY = A(index, 2) + (x - A(index, 1)) * k;
        
        if (dy < 0 && tempY < y - precision) || (dy > 0 && tempY > y + precision)
            
            while 1
                tempX = A(index, 1) + (y - A(index, 2)) / k;

                if (dx < 0 && tempX <= x + precision) || (dx > 0 && tempX >= x - precision)
                    break;
                end

                if abs(y - y1) < abs(dy) - precision
                    A(index, 1) = tempX;
                    A(index, 2) = y1;
                    A(index, 3) = floor(x1 * dimX + precision / dimX) + 1;
                    A(index, 4) = floor(y1 * dimY + precision / dimY) + 1;
                    %?????????????????????
                    index = index + 1;
                end

                A(index + 1, 1) = tempX;
                A(index + 1, 2) = y;
                A(index + 1, 3) = floor(tempX * dimX + precision / dimX) + 1;
                A(index + 1, 4) = floor(y * dimY + precision / dimY) + 1;

                index = index + 1;
                y = y + dy;
                
            end
        end
        
        if abs(x - x1) < abs(dx) - precision
            
        end
    end

%PLOT
xp = zeros(1, size(A));
yp = zeros(1, size(A));
for index = 1 : size(A)
   xp(index) = A(index, 1);
   yp(index) = A(index, 2);
end
plot(xp, yp);